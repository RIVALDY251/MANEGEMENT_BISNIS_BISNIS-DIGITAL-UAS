import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/auth/forgot_password_screen.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/business/business_profile_screen.dart';
import '../../presentation/screens/financial/financial_screen.dart';
import '../../presentation/screens/product/product_list_screen.dart';
import '../../presentation/screens/crm/crm_screen.dart';
import '../../presentation/screens/invoice/invoice_list_screen.dart';
import '../../presentation/screens/analytics/analytics_screen.dart';
import '../../presentation/screens/ai_insight/ai_insight_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/settings/change_password_screen.dart';
import '../../presentation/screens/settings/privacy_policy_screen.dart';
import '../../presentation/screens/settings/terms_screen.dart';
import '../../presentation/screens/notification/notification_screen.dart';
import '../../presentation/screens/auth/email_verification_screen.dart';
import '../../presentation/screens/product/product_detail_screen.dart';
import '../../presentation/screens/invoice/invoice_create_screen.dart';
import '../../presentation/screens/crm/customer_detail_screen.dart';
import '../../presentation/screens/product/product_transaction_history_screen.dart';
import '../../presentation/screens/invoice/invoice_detail_screen.dart';
import '../../presentation/screens/settings/edit_profile_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/business-profile',
        name: 'business-profile',
        builder: (context, state) => const BusinessProfileScreen(),
      ),
      GoRoute(
        path: '/financial',
        name: 'financial',
        builder: (context, state) => const FinancialScreen(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        path: '/crm',
        name: 'crm',
        builder: (context, state) => const CRMScreen(),
      ),
      GoRoute(
        path: '/invoices',
        name: 'invoices',
        builder: (context, state) => const InvoiceListScreen(),
      ),
      GoRoute(
        path: '/analytics',
        name: 'analytics',
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: '/ai-insight',
        name: 'ai-insight',
        builder: (context, state) => const AIInsightScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/email-verification',
        name: 'email-verification',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          return EmailVerificationScreen(email: email);
        },
      ),
      GoRoute(
        path: '/product-detail',
        name: 'product-detail',
        builder: (context, state) {
          final product = state.extra as Map<String, dynamic>?;
          final isEdit = state.uri.queryParameters['edit'] == 'true';
          return ProductDetailScreen(product: product, isEdit: isEdit);
        },
      ),
      GoRoute(
        path: '/invoice-create',
        name: 'invoice-create',
        builder: (context, state) => const InvoiceCreateScreen(),
      ),
      GoRoute(
        path: '/change-password',
        name: 'change-password',
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: '/privacy-policy',
        name: 'privacy-policy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: '/terms',
        name: 'terms',
        builder: (context, state) => const TermsScreen(),
      ),
      GoRoute(
        path: '/customer-detail',
        name: 'customer-detail',
        builder: (context, state) {
          final customer = state.extra as Map<String, dynamic>;
          return CustomerDetailScreen(customer: customer);
        },
      ),
      GoRoute(
        path: '/product-transaction-history',
        name: 'product-transaction-history',
        builder: (context, state) {
          final productId = state.uri.queryParameters['productId'] ?? '';
          final productName = state.uri.queryParameters['productName'] ?? 'Produk';
          return ProductTransactionHistoryScreen(
            productId: productId,
            productName: productName,
          );
        },
      ),
      GoRoute(
        path: '/invoice-detail',
        name: 'invoice-detail',
        builder: (context, state) {
          final invoice = state.extra as Map<String, dynamic>;
          return InvoiceDetailScreen(invoice: invoice);
        },
      ),
      GoRoute(
        path: '/edit-profile',
        name: 'edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
    ],
  );
}

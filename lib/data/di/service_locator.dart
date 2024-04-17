import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_supabase/data/service/supabase_service.dart';
import 'package:test_supabase/data/supabase/collection_keys.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );
  locator.registerLazySingleton<CollectionKeys>(
    () => CollectionKeys(),
  );
  locator.registerLazySingleton<SupaBaseServiceImpl>(
    () => SupaBaseServiceImpl(
      client: locator<SupabaseClient>(),
      sbKeys: locator<CollectionKeys>(),
    ),
  );
}

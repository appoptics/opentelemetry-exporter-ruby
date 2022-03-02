#include "oboe_otel_api.hpp"

bool Otel::sendEvent(const std::string bson_str, int len) {
    int retval = -1;

    retval = oboe_raw_send(OBOE_SEND_EVENT, bson_str.c_str(), bson_str.length());

    if (retval < 0)
        OBOE_DEBUG_LOG_ERROR(OBOE_MODULE_LIBOBOE, "Raw send failed - reporter returned %d", retval);

    return (retval >= 0);
}

extern "C" void Init_oboe(void) {
// create Ruby Module: AppOpticsAPM::CProfiler
    static VALUE rb_mSolarwinds = rb_define_module("Solarwinds");
    static VALUE rb_mExporter = rb_define_module_under(rb_mAppOpticsAPM, "Exporter");

// TODO WIP
//    rb_define_singleton_method(rb_mExporter, "get_interval", reinterpret_cast<VALUE (*)(...)>(Exporter::get_interval), 0);

}
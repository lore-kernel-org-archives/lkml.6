Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933242AbeCPRUd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:20:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:13215 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933130AbeCPRU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:20:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,316,1517904000";
   d="gz'50?scan'50,208,50";a="212004321"
Date: Sat, 17 Mar 2018 01:19:54 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:perf/core 1/2] drivers//perf/qcom_l2_pmu.c:598:13: error:
 invalid storage class for function 'l2_cache_event_start'
Message-ID: <201803170151.rTZuY1Yd%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
head:   bbb68468641547d56c83012670bcaf77f3dacd64
commit: 7eb709f29593aced51901cb53565477762800722 [1/2] perf: Fix sibling iteration
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7eb709f29593aced51901cb53565477762800722
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   drivers//perf/qcom_l2_pmu.c: In function 'l2_cache_event_init':
>> drivers//perf/qcom_l2_pmu.c:598:13: error: invalid storage class for function 'l2_cache_event_start'
    static void l2_cache_event_start(struct perf_event *event, int flags)
                ^~~~~~~~~~~~~~~~~~~~
>> drivers//perf/qcom_l2_pmu.c:598:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void l2_cache_event_start(struct perf_event *event, int flags)
    ^~~~~~
>> drivers//perf/qcom_l2_pmu.c:629:13: error: invalid storage class for function 'l2_cache_event_stop'
    static void l2_cache_event_stop(struct perf_event *event, int flags)
                ^~~~~~~~~~~~~~~~~~~
>> drivers//perf/qcom_l2_pmu.c:645:12: error: invalid storage class for function 'l2_cache_event_add'
    static int l2_cache_event_add(struct perf_event *event, int flags)
               ^~~~~~~~~~~~~~~~~~
>> drivers//perf/qcom_l2_pmu.c:672:13: error: invalid storage class for function 'l2_cache_event_del'
    static void l2_cache_event_del(struct perf_event *event, int flags)
                ^~~~~~~~~~~~~~~~~~
>> drivers//perf/qcom_l2_pmu.c:687:13: error: invalid storage class for function 'l2_cache_event_read'
    static void l2_cache_event_read(struct perf_event *event)
                ^~~~~~~~~~~~~~~~~~~
>> drivers//perf/qcom_l2_pmu.c:692:16: error: invalid storage class for function 'l2_cache_pmu_cpumask_show'
    static ssize_t l2_cache_pmu_cpumask_show(struct device *dev,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20:0,
                    from include/linux/device.h:16,
                    from include/linux/acpi.h:27,
                    from drivers//perf/qcom_l2_pmu.c:12:
>> drivers//perf/qcom_l2_pmu.c:702:28: error: initializer element is not constant
      __ATTR(cpumask, S_IRUGO, l2_cache_pmu_cpumask_show, NULL);
                               ^
   include/linux/sysfs.h:104:10: note: in definition of macro '__ATTR'
     .show = _show,      \
             ^~~~~
   drivers//perf/qcom_l2_pmu.c:702:28: note: (near initialization for 'l2_cache_pmu_cpumask_attr.show')
      __ATTR(cpumask, S_IRUGO, l2_cache_pmu_cpumask_show, NULL);
                               ^
   include/linux/sysfs.h:104:10: note: in definition of macro '__ATTR'
     .show = _show,      \
             ^~~~~
   In file included from drivers//perf/qcom_l2_pmu.c:24:0:
>> drivers//perf/qcom_l2_pmu.c:714:17: error: invalid storage class for function 'l2_code_show'
    PMU_FORMAT_ATTR(l2_code,   "config:4-11");
                    ^
   include/linux/perf_event.h:1377:1: note: in definition of macro 'PMU_FORMAT_ATTR'
    _name##_show(struct device *dev,     \
    ^~~~~
   In file included from include/linux/kobject.h:20:0,
                    from include/linux/device.h:16,
                    from include/linux/acpi.h:27,
                    from drivers//perf/qcom_l2_pmu.c:12:
   drivers//perf/qcom_l2_pmu.c:714:17: error: initializer element is not constant
    PMU_FORMAT_ATTR(l2_code,   "config:4-11");
                    ^
   include/linux/sysfs.h:117:10: note: in definition of macro '__ATTR_RO'
     .show = _name##_show,      \
             ^~~~~
>> drivers//perf/qcom_l2_pmu.c:714:1: note: in expansion of macro 'PMU_FORMAT_ATTR'
    PMU_FORMAT_ATTR(l2_code,   "config:4-11");
    ^~~~~~~~~~~~~~~
   drivers//perf/qcom_l2_pmu.c:714:17: note: (near initialization for 'format_attr_l2_code.show')
    PMU_FORMAT_ATTR(l2_code,   "config:4-11");
                    ^
   include/linux/sysfs.h:117:10: note: in definition of macro '__ATTR_RO'
     .show = _name##_show,      \
             ^~~~~
>> drivers//perf/qcom_l2_pmu.c:714:1: note: in expansion of macro 'PMU_FORMAT_ATTR'
    PMU_FORMAT_ATTR(l2_code,   "config:4-11");
    ^~~~~~~~~~~~~~~
   In file included from drivers//perf/qcom_l2_pmu.c:24:0:
>> drivers//perf/qcom_l2_pmu.c:715:17: error: invalid storage class for function 'l2_group_show'
    PMU_FORMAT_ATTR(l2_group,  "config:0-3");
                    ^
   include/linux/perf_event.h:1377:1: note: in definition of macro 'PMU_FORMAT_ATTR'
    _name##_show(struct device *dev,     \
    ^~~~~
   In file included from include/linux/kobject.h:20:0,
                    from include/linux/device.h:16,
                    from include/linux/acpi.h:27,
                    from drivers//perf/qcom_l2_pmu.c:12:
   drivers//perf/qcom_l2_pmu.c:715:17: error: initializer element is not constant
    PMU_FORMAT_ATTR(l2_group,  "config:0-3");
                    ^
   include/linux/sysfs.h:117:10: note: in definition of macro '__ATTR_RO'
     .show = _name##_show,      \
             ^~~~~
   drivers//perf/qcom_l2_pmu.c:715:1: note: in expansion of macro 'PMU_FORMAT_ATTR'
    PMU_FORMAT_ATTR(l2_group,  "config:0-3");
    ^~~~~~~~~~~~~~~
   drivers//perf/qcom_l2_pmu.c:715:17: note: (near initialization for 'format_attr_l2_group.show')
    PMU_FORMAT_ATTR(l2_group,  "config:0-3");
                    ^
   include/linux/sysfs.h:117:10: note: in definition of macro '__ATTR_RO'
     .show = _name##_show,      \
             ^~~~~
   drivers//perf/qcom_l2_pmu.c:715:1: note: in expansion of macro 'PMU_FORMAT_ATTR'
    PMU_FORMAT_ATTR(l2_group,  "config:0-3");
    ^~~~~~~~~~~~~~~
   In file included from drivers//perf/qcom_l2_pmu.c:24:0:
>> drivers//perf/qcom_l2_pmu.c:716:17: error: invalid storage class for function 'event_show'
    PMU_FORMAT_ATTR(event,     "config:0-11");
                    ^
   include/linux/perf_event.h:1377:1: note: in definition of macro 'PMU_FORMAT_ATTR'
    _name##_show(struct device *dev,     \
    ^~~~~
   In file included from include/linux/kobject.h:20:0,
                    from include/linux/device.h:16,
                    from include/linux/acpi.h:27,
                    from drivers//perf/qcom_l2_pmu.c:12:
   drivers//perf/qcom_l2_pmu.c:716:17: error: initializer element is not constant
    PMU_FORMAT_ATTR(event,     "config:0-11");
                    ^
   include/linux/sysfs.h:117:10: note: in definition of macro '__ATTR_RO'
     .show = _name##_show,      \
             ^~~~~
   drivers//perf/qcom_l2_pmu.c:716:1: note: in expansion of macro 'PMU_FORMAT_ATTR'
    PMU_FORMAT_ATTR(event,     "config:0-11");
    ^~~~~~~~~~~~~~~
   drivers//perf/qcom_l2_pmu.c:716:17: note: (near initialization for 'format_attr_event.show')
    PMU_FORMAT_ATTR(event,     "config:0-11");
                    ^
   include/linux/sysfs.h:117:10: note: in definition of macro '__ATTR_RO'
     .show = _name##_show,      \
             ^~~~~
   drivers//perf/qcom_l2_pmu.c:716:1: note: in expansion of macro 'PMU_FORMAT_ATTR'
    PMU_FORMAT_ATTR(event,     "config:0-11");
    ^~~~~~~~~~~~~~~
>> drivers//perf/qcom_l2_pmu.c:730:16: error: invalid storage class for function 'l2cache_pmu_event_show'
    static ssize_t l2cache_pmu_event_show(struct device *dev,
                   ^~~~~~~~~~~~~~~~~~~~~~
   drivers//perf/qcom_l2_pmu.c:740:2: error: initializer element is not constant
     (&((struct perf_pmu_events_attr[]) {         \
     ^
>> drivers//perf/qcom_l2_pmu.c:746:2: note: in expansion of macro 'L2CACHE_EVENT_ATTR'
     L2CACHE_EVENT_ATTR(cycles, L2_EVENT_CYCLES),
     ^~~~~~~~~~~~~~~~~~
   drivers//perf/qcom_l2_pmu.c:740:2: note: (near initialization for 'l2_cache_pmu_events[0]')
     (&((struct perf_pmu_events_attr[]) {         \
     ^
>> drivers//perf/qcom_l2_pmu.c:746:2: note: in expansion of macro 'L2CACHE_EVENT_ATTR'
     L2CACHE_EVENT_ATTR(cycles, L2_EVENT_CYCLES),
     ^~~~~~~~~~~~~~~~~~
>> drivers//perf/qcom_l2_pmu.c:781:12: error: invalid storage class for function 'get_num_counters'
    static int get_num_counters(void)
               ^~~~~~~~~~~~~~~~
>> drivers//perf/qcom_l2_pmu.c:794:28: error: invalid storage class for function 'l2_cache_associate_cpu_with_cluster'
    static struct cluster_pmu *l2_cache_associate_cpu_with_cluster(
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers//perf/qcom_l2_pmu.c:827:12: error: invalid storage class for function 'l2cache_pmu_online_cpu'
    static int l2cache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
               ^~~~~~~~~~~~~~~~~~~~~~
>> drivers//perf/qcom_l2_pmu.c:862:12: error: invalid storage class for function 'l2cache_pmu_offline_cpu'
    static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
               ^~~~~~~~~~~~~~~~~~~~~~~

vim +/l2_cache_event_start +598 drivers//perf/qcom_l2_pmu.c

21bdbb710 Neil Leeder 2017-02-07  597  
21bdbb710 Neil Leeder 2017-02-07 @598  static void l2_cache_event_start(struct perf_event *event, int flags)
21bdbb710 Neil Leeder 2017-02-07  599  {
21bdbb710 Neil Leeder 2017-02-07  600  	struct cluster_pmu *cluster;
21bdbb710 Neil Leeder 2017-02-07  601  	struct hw_perf_event *hwc = &event->hw;
21bdbb710 Neil Leeder 2017-02-07  602  	int idx = hwc->idx;
21bdbb710 Neil Leeder 2017-02-07  603  	u32 config;
21bdbb710 Neil Leeder 2017-02-07  604  	u32 event_cc, event_group;
21bdbb710 Neil Leeder 2017-02-07  605  
21bdbb710 Neil Leeder 2017-02-07  606  	hwc->state = 0;
21bdbb710 Neil Leeder 2017-02-07  607  
21bdbb710 Neil Leeder 2017-02-07  608  	cluster = get_cluster_pmu(to_l2cache_pmu(event->pmu), event->cpu);
21bdbb710 Neil Leeder 2017-02-07  609  
21bdbb710 Neil Leeder 2017-02-07  610  	l2_cache_cluster_set_period(cluster, hwc);
21bdbb710 Neil Leeder 2017-02-07  611  
21bdbb710 Neil Leeder 2017-02-07  612  	if (hwc->config_base == L2CYCLE_CTR_RAW_CODE) {
21bdbb710 Neil Leeder 2017-02-07  613  		cluster_pmu_set_evccntcr(0);
21bdbb710 Neil Leeder 2017-02-07  614  	} else {
21bdbb710 Neil Leeder 2017-02-07  615  		config = hwc->config_base;
21bdbb710 Neil Leeder 2017-02-07  616  		event_cc    = L2_EVT_CODE(config);
21bdbb710 Neil Leeder 2017-02-07  617  		event_group = L2_EVT_GROUP(config);
21bdbb710 Neil Leeder 2017-02-07  618  
21bdbb710 Neil Leeder 2017-02-07  619  		cluster_pmu_set_evcntcr(idx, 0);
21bdbb710 Neil Leeder 2017-02-07  620  		cluster_pmu_set_evtyper(idx, event_group);
21bdbb710 Neil Leeder 2017-02-07  621  		cluster_pmu_set_resr(cluster, event_group, event_cc);
21bdbb710 Neil Leeder 2017-02-07  622  		cluster_pmu_set_evfilter_sys_mode(idx);
21bdbb710 Neil Leeder 2017-02-07  623  	}
21bdbb710 Neil Leeder 2017-02-07  624  
21bdbb710 Neil Leeder 2017-02-07  625  	cluster_pmu_counter_enable_interrupt(idx);
21bdbb710 Neil Leeder 2017-02-07  626  	cluster_pmu_counter_enable(idx);
21bdbb710 Neil Leeder 2017-02-07  627  }
21bdbb710 Neil Leeder 2017-02-07  628  
21bdbb710 Neil Leeder 2017-02-07 @629  static void l2_cache_event_stop(struct perf_event *event, int flags)
21bdbb710 Neil Leeder 2017-02-07  630  {
21bdbb710 Neil Leeder 2017-02-07  631  	struct hw_perf_event *hwc = &event->hw;
21bdbb710 Neil Leeder 2017-02-07  632  	int idx = hwc->idx;
21bdbb710 Neil Leeder 2017-02-07  633  
21bdbb710 Neil Leeder 2017-02-07  634  	if (hwc->state & PERF_HES_STOPPED)
21bdbb710 Neil Leeder 2017-02-07  635  		return;
21bdbb710 Neil Leeder 2017-02-07  636  
21bdbb710 Neil Leeder 2017-02-07  637  	cluster_pmu_counter_disable_interrupt(idx);
21bdbb710 Neil Leeder 2017-02-07  638  	cluster_pmu_counter_disable(idx);
21bdbb710 Neil Leeder 2017-02-07  639  
21bdbb710 Neil Leeder 2017-02-07  640  	if (flags & PERF_EF_UPDATE)
21bdbb710 Neil Leeder 2017-02-07  641  		l2_cache_event_update(event);
21bdbb710 Neil Leeder 2017-02-07  642  	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
21bdbb710 Neil Leeder 2017-02-07  643  }
21bdbb710 Neil Leeder 2017-02-07  644  
21bdbb710 Neil Leeder 2017-02-07 @645  static int l2_cache_event_add(struct perf_event *event, int flags)
21bdbb710 Neil Leeder 2017-02-07  646  {
21bdbb710 Neil Leeder 2017-02-07  647  	struct hw_perf_event *hwc = &event->hw;
21bdbb710 Neil Leeder 2017-02-07  648  	int idx;
21bdbb710 Neil Leeder 2017-02-07  649  	int err = 0;
21bdbb710 Neil Leeder 2017-02-07  650  	struct cluster_pmu *cluster;
21bdbb710 Neil Leeder 2017-02-07  651  
21bdbb710 Neil Leeder 2017-02-07  652  	cluster = get_cluster_pmu(to_l2cache_pmu(event->pmu), event->cpu);
21bdbb710 Neil Leeder 2017-02-07  653  
21bdbb710 Neil Leeder 2017-02-07  654  	idx = l2_cache_get_event_idx(cluster, event);
21bdbb710 Neil Leeder 2017-02-07  655  	if (idx < 0)
21bdbb710 Neil Leeder 2017-02-07  656  		return idx;
21bdbb710 Neil Leeder 2017-02-07  657  
21bdbb710 Neil Leeder 2017-02-07  658  	hwc->idx = idx;
21bdbb710 Neil Leeder 2017-02-07  659  	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
21bdbb710 Neil Leeder 2017-02-07  660  	cluster->events[idx] = event;
21bdbb710 Neil Leeder 2017-02-07  661  	local64_set(&hwc->prev_count, 0);
21bdbb710 Neil Leeder 2017-02-07  662  
21bdbb710 Neil Leeder 2017-02-07  663  	if (flags & PERF_EF_START)
21bdbb710 Neil Leeder 2017-02-07  664  		l2_cache_event_start(event, flags);
21bdbb710 Neil Leeder 2017-02-07  665  
21bdbb710 Neil Leeder 2017-02-07  666  	/* Propagate changes to the userspace mapping. */
21bdbb710 Neil Leeder 2017-02-07  667  	perf_event_update_userpage(event);
21bdbb710 Neil Leeder 2017-02-07  668  
21bdbb710 Neil Leeder 2017-02-07  669  	return err;
21bdbb710 Neil Leeder 2017-02-07  670  }
21bdbb710 Neil Leeder 2017-02-07  671  
21bdbb710 Neil Leeder 2017-02-07 @672  static void l2_cache_event_del(struct perf_event *event, int flags)
21bdbb710 Neil Leeder 2017-02-07  673  {
21bdbb710 Neil Leeder 2017-02-07  674  	struct hw_perf_event *hwc = &event->hw;
21bdbb710 Neil Leeder 2017-02-07  675  	struct cluster_pmu *cluster;
21bdbb710 Neil Leeder 2017-02-07  676  	int idx = hwc->idx;
21bdbb710 Neil Leeder 2017-02-07  677  
21bdbb710 Neil Leeder 2017-02-07  678  	cluster = get_cluster_pmu(to_l2cache_pmu(event->pmu), event->cpu);
21bdbb710 Neil Leeder 2017-02-07  679  
21bdbb710 Neil Leeder 2017-02-07  680  	l2_cache_event_stop(event, flags | PERF_EF_UPDATE);
21bdbb710 Neil Leeder 2017-02-07  681  	cluster->events[idx] = NULL;
21bdbb710 Neil Leeder 2017-02-07  682  	l2_cache_clear_event_idx(cluster, event);
21bdbb710 Neil Leeder 2017-02-07  683  
21bdbb710 Neil Leeder 2017-02-07  684  	perf_event_update_userpage(event);
21bdbb710 Neil Leeder 2017-02-07  685  }
21bdbb710 Neil Leeder 2017-02-07  686  
21bdbb710 Neil Leeder 2017-02-07 @687  static void l2_cache_event_read(struct perf_event *event)
21bdbb710 Neil Leeder 2017-02-07  688  {
21bdbb710 Neil Leeder 2017-02-07  689  	l2_cache_event_update(event);
21bdbb710 Neil Leeder 2017-02-07  690  }
21bdbb710 Neil Leeder 2017-02-07  691  
21bdbb710 Neil Leeder 2017-02-07 @692  static ssize_t l2_cache_pmu_cpumask_show(struct device *dev,
21bdbb710 Neil Leeder 2017-02-07  693  					 struct device_attribute *attr,
21bdbb710 Neil Leeder 2017-02-07  694  					 char *buf)
21bdbb710 Neil Leeder 2017-02-07  695  {
21bdbb710 Neil Leeder 2017-02-07  696  	struct l2cache_pmu *l2cache_pmu = to_l2cache_pmu(dev_get_drvdata(dev));
21bdbb710 Neil Leeder 2017-02-07  697  
21bdbb710 Neil Leeder 2017-02-07  698  	return cpumap_print_to_pagebuf(true, buf, &l2cache_pmu->cpumask);
21bdbb710 Neil Leeder 2017-02-07  699  }
21bdbb710 Neil Leeder 2017-02-07  700  
21bdbb710 Neil Leeder 2017-02-07  701  static struct device_attribute l2_cache_pmu_cpumask_attr =
21bdbb710 Neil Leeder 2017-02-07 @702  		__ATTR(cpumask, S_IRUGO, l2_cache_pmu_cpumask_show, NULL);
21bdbb710 Neil Leeder 2017-02-07  703  
21bdbb710 Neil Leeder 2017-02-07  704  static struct attribute *l2_cache_pmu_cpumask_attrs[] = {
21bdbb710 Neil Leeder 2017-02-07  705  	&l2_cache_pmu_cpumask_attr.attr,
21bdbb710 Neil Leeder 2017-02-07  706  	NULL,
21bdbb710 Neil Leeder 2017-02-07  707  };
21bdbb710 Neil Leeder 2017-02-07  708  
21bdbb710 Neil Leeder 2017-02-07  709  static struct attribute_group l2_cache_pmu_cpumask_group = {
21bdbb710 Neil Leeder 2017-02-07  710  	.attrs = l2_cache_pmu_cpumask_attrs,
21bdbb710 Neil Leeder 2017-02-07  711  };
21bdbb710 Neil Leeder 2017-02-07  712  
21bdbb710 Neil Leeder 2017-02-07  713  /* CCG format for perf RAW codes. */
21bdbb710 Neil Leeder 2017-02-07 @714  PMU_FORMAT_ATTR(l2_code,   "config:4-11");
21bdbb710 Neil Leeder 2017-02-07 @715  PMU_FORMAT_ATTR(l2_group,  "config:0-3");
b65423ed4 Neil Leeder 2017-09-14 @716  PMU_FORMAT_ATTR(event,     "config:0-11");
b65423ed4 Neil Leeder 2017-09-14  717  
21bdbb710 Neil Leeder 2017-02-07  718  static struct attribute *l2_cache_pmu_formats[] = {
21bdbb710 Neil Leeder 2017-02-07  719  	&format_attr_l2_code.attr,
21bdbb710 Neil Leeder 2017-02-07  720  	&format_attr_l2_group.attr,
b65423ed4 Neil Leeder 2017-09-14  721  	&format_attr_event.attr,
21bdbb710 Neil Leeder 2017-02-07  722  	NULL,
21bdbb710 Neil Leeder 2017-02-07  723  };
21bdbb710 Neil Leeder 2017-02-07  724  
21bdbb710 Neil Leeder 2017-02-07  725  static struct attribute_group l2_cache_pmu_format_group = {
21bdbb710 Neil Leeder 2017-02-07  726  	.name = "format",
21bdbb710 Neil Leeder 2017-02-07  727  	.attrs = l2_cache_pmu_formats,
21bdbb710 Neil Leeder 2017-02-07  728  };
21bdbb710 Neil Leeder 2017-02-07  729  
b65423ed4 Neil Leeder 2017-09-14 @730  static ssize_t l2cache_pmu_event_show(struct device *dev,
b65423ed4 Neil Leeder 2017-09-14  731  				      struct device_attribute *attr, char *page)
b65423ed4 Neil Leeder 2017-09-14  732  {
b65423ed4 Neil Leeder 2017-09-14  733  	struct perf_pmu_events_attr *pmu_attr;
b65423ed4 Neil Leeder 2017-09-14  734  
b65423ed4 Neil Leeder 2017-09-14  735  	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
b65423ed4 Neil Leeder 2017-09-14  736  	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
b65423ed4 Neil Leeder 2017-09-14  737  }
b65423ed4 Neil Leeder 2017-09-14  738  
b65423ed4 Neil Leeder 2017-09-14  739  #define L2CACHE_EVENT_ATTR(_name, _id)					     \
b65423ed4 Neil Leeder 2017-09-14 @740  	(&((struct perf_pmu_events_attr[]) {				     \
b65423ed4 Neil Leeder 2017-09-14  741  		{ .attr = __ATTR(_name, 0444, l2cache_pmu_event_show, NULL), \
b65423ed4 Neil Leeder 2017-09-14  742  		  .id = _id, }						     \
b65423ed4 Neil Leeder 2017-09-14  743  	})[0].attr.attr)
b65423ed4 Neil Leeder 2017-09-14  744  
b65423ed4 Neil Leeder 2017-09-14  745  static struct attribute *l2_cache_pmu_events[] = {
b65423ed4 Neil Leeder 2017-09-14 @746  	L2CACHE_EVENT_ATTR(cycles, L2_EVENT_CYCLES),
b65423ed4 Neil Leeder 2017-09-14  747  	L2CACHE_EVENT_ATTR(dcache-ops, L2_EVENT_DCACHE_OPS),
b65423ed4 Neil Leeder 2017-09-14  748  	L2CACHE_EVENT_ATTR(icache-ops, L2_EVENT_ICACHE_OPS),
b65423ed4 Neil Leeder 2017-09-14  749  	L2CACHE_EVENT_ATTR(tlbi, L2_EVENT_TLBI),
b65423ed4 Neil Leeder 2017-09-14  750  	L2CACHE_EVENT_ATTR(barriers, L2_EVENT_BARRIERS),
b65423ed4 Neil Leeder 2017-09-14  751  	L2CACHE_EVENT_ATTR(total-reads, L2_EVENT_TOTAL_READS),
b65423ed4 Neil Leeder 2017-09-14  752  	L2CACHE_EVENT_ATTR(total-writes, L2_EVENT_TOTAL_WRITES),
b65423ed4 Neil Leeder 2017-09-14  753  	L2CACHE_EVENT_ATTR(total-requests, L2_EVENT_TOTAL_REQUESTS),
b65423ed4 Neil Leeder 2017-09-14  754  	L2CACHE_EVENT_ATTR(ldrex, L2_EVENT_LDREX),
b65423ed4 Neil Leeder 2017-09-14  755  	L2CACHE_EVENT_ATTR(strex, L2_EVENT_STREX),
b65423ed4 Neil Leeder 2017-09-14  756  	L2CACHE_EVENT_ATTR(clrex, L2_EVENT_CLREX),
b65423ed4 Neil Leeder 2017-09-14  757  	NULL
b65423ed4 Neil Leeder 2017-09-14  758  };
b65423ed4 Neil Leeder 2017-09-14  759  
b65423ed4 Neil Leeder 2017-09-14  760  static struct attribute_group l2_cache_pmu_events_group = {
b65423ed4 Neil Leeder 2017-09-14  761  	.name = "events",
b65423ed4 Neil Leeder 2017-09-14  762  	.attrs = l2_cache_pmu_events,
b65423ed4 Neil Leeder 2017-09-14  763  };
b65423ed4 Neil Leeder 2017-09-14  764  
21bdbb710 Neil Leeder 2017-02-07  765  static const struct attribute_group *l2_cache_pmu_attr_grps[] = {
21bdbb710 Neil Leeder 2017-02-07  766  	&l2_cache_pmu_format_group,
21bdbb710 Neil Leeder 2017-02-07  767  	&l2_cache_pmu_cpumask_group,
b65423ed4 Neil Leeder 2017-09-14  768  	&l2_cache_pmu_events_group,
21bdbb710 Neil Leeder 2017-02-07  769  	NULL,
21bdbb710 Neil Leeder 2017-02-07  770  };
21bdbb710 Neil Leeder 2017-02-07  771  
21bdbb710 Neil Leeder 2017-02-07  772  /*
21bdbb710 Neil Leeder 2017-02-07  773   * Generic device handlers
21bdbb710 Neil Leeder 2017-02-07  774   */
21bdbb710 Neil Leeder 2017-02-07  775  
21bdbb710 Neil Leeder 2017-02-07  776  static const struct acpi_device_id l2_cache_pmu_acpi_match[] = {
21bdbb710 Neil Leeder 2017-02-07  777  	{ "QCOM8130", },
21bdbb710 Neil Leeder 2017-02-07  778  	{ }
21bdbb710 Neil Leeder 2017-02-07  779  };
21bdbb710 Neil Leeder 2017-02-07  780  
21bdbb710 Neil Leeder 2017-02-07 @781  static int get_num_counters(void)
21bdbb710 Neil Leeder 2017-02-07  782  {
21bdbb710 Neil Leeder 2017-02-07  783  	int val;
21bdbb710 Neil Leeder 2017-02-07  784  
21bdbb710 Neil Leeder 2017-02-07  785  	val = get_l2_indirect_reg(L2PMCR);
21bdbb710 Neil Leeder 2017-02-07  786  
21bdbb710 Neil Leeder 2017-02-07  787  	/*
21bdbb710 Neil Leeder 2017-02-07  788  	 * Read number of counters from L2PMCR and add 1
21bdbb710 Neil Leeder 2017-02-07  789  	 * for the cycle counter.
21bdbb710 Neil Leeder 2017-02-07  790  	 */
21bdbb710 Neil Leeder 2017-02-07  791  	return ((val >> L2PMCR_NUM_EV_SHIFT) & L2PMCR_NUM_EV_MASK) + 1;
21bdbb710 Neil Leeder 2017-02-07  792  }
21bdbb710 Neil Leeder 2017-02-07  793  
21bdbb710 Neil Leeder 2017-02-07 @794  static struct cluster_pmu *l2_cache_associate_cpu_with_cluster(
21bdbb710 Neil Leeder 2017-02-07  795  	struct l2cache_pmu *l2cache_pmu, int cpu)
21bdbb710 Neil Leeder 2017-02-07  796  {
21bdbb710 Neil Leeder 2017-02-07  797  	u64 mpidr;
21bdbb710 Neil Leeder 2017-02-07  798  	int cpu_cluster_id;
21bdbb710 Neil Leeder 2017-02-07  799  	struct cluster_pmu *cluster = NULL;
21bdbb710 Neil Leeder 2017-02-07  800  
21bdbb710 Neil Leeder 2017-02-07  801  	/*
21bdbb710 Neil Leeder 2017-02-07  802  	 * This assumes that the cluster_id is in MPIDR[aff1] for
21bdbb710 Neil Leeder 2017-02-07  803  	 * single-threaded cores, and MPIDR[aff2] for multi-threaded
21bdbb710 Neil Leeder 2017-02-07  804  	 * cores. This logic will have to be updated if this changes.
21bdbb710 Neil Leeder 2017-02-07  805  	 */
21bdbb710 Neil Leeder 2017-02-07  806  	mpidr = read_cpuid_mpidr();
21bdbb710 Neil Leeder 2017-02-07  807  	if (mpidr & MPIDR_MT_BITMASK)
21bdbb710 Neil Leeder 2017-02-07  808  		cpu_cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
21bdbb710 Neil Leeder 2017-02-07  809  	else
21bdbb710 Neil Leeder 2017-02-07  810  		cpu_cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
21bdbb710 Neil Leeder 2017-02-07  811  
21bdbb710 Neil Leeder 2017-02-07  812  	list_for_each_entry(cluster, &l2cache_pmu->clusters, next) {
21bdbb710 Neil Leeder 2017-02-07  813  		if (cluster->cluster_id != cpu_cluster_id)
21bdbb710 Neil Leeder 2017-02-07  814  			continue;
21bdbb710 Neil Leeder 2017-02-07  815  
21bdbb710 Neil Leeder 2017-02-07  816  		dev_info(&l2cache_pmu->pdev->dev,
21bdbb710 Neil Leeder 2017-02-07  817  			 "CPU%d associated with cluster %d\n", cpu,
21bdbb710 Neil Leeder 2017-02-07  818  			 cluster->cluster_id);
21bdbb710 Neil Leeder 2017-02-07  819  		cpumask_set_cpu(cpu, &cluster->cluster_cpus);
21bdbb710 Neil Leeder 2017-02-07  820  		*per_cpu_ptr(l2cache_pmu->pmu_cluster, cpu) = cluster;
21bdbb710 Neil Leeder 2017-02-07  821  		break;
21bdbb710 Neil Leeder 2017-02-07  822  	}
21bdbb710 Neil Leeder 2017-02-07  823  
21bdbb710 Neil Leeder 2017-02-07  824  	return cluster;
21bdbb710 Neil Leeder 2017-02-07  825  }
21bdbb710 Neil Leeder 2017-02-07  826  

:::::: The code at line 598 was first introduced by commit
:::::: 21bdbb7102edeaebb5ec4ef530c8f442f7562c96 perf: add qcom l2 cache perf events driver

:::::: TO: Neil Leeder <nleeder@codeaurora.org>
:::::: CC: Will Deacon <will.deacon@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--HlL+5n6rz5pIUxbD
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
dl29AwA=

--HlL+5n6rz5pIUxbD--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeERT5K (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:57:10 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:37014
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751156AbeERT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:57:09 -0400
X-IronPort-AV: E=Sophos;i="5.49,415,1520895600";
   d="scan'208";a="265738474"
Date: Fri, 18 May 2018 21:57:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Rex Zhu <Rex.Zhu@amd.com>
cc: Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
        kbuild-all@01.org
Subject: drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c:1001:52-53:
 asic_setup: first occurrence line 1004, second occurrence line 1031 (fwd)
Message-ID: <alpine.DEB.2.20.1805182156170.2430@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure has two initializations of the field asic_setup.

julia

---------- Forwarded message ----------
Date: Sat, 19 May 2018 02:35:04 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c:1001:52-53:
    asic_setup: first occurrence line 1004, second occurrence line 1031

CC: kbuild-all@01.org
CC: linux-kernel@vger.kernel.org
TO: Rex Zhu <Rex.Zhu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3acf4e395260e3bd30a6fa29ba7eada4bf7566ca
commit: c425688520990d6cec769faaa97f4af45d361fd1 drm/amd/pp: Replace rv_* with smu10_*
date:   9 weeks ago
:::::: branch date: 20 hours ago
:::::: commit date: 9 weeks ago

>> drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c:1001:52-53: asic_setup: first occurrence line 1004, second occurrence line 1031

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c425688520990d6cec769faaa97f4af45d361fd1
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout c425688520990d6cec769faaa97f4af45d361fd1
vim +1001 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c

b01a4f48 drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c    Eric Huang 2018-02-06  1000
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06 @1001  static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1002  	.backend_init = smu10_hwmgr_backend_init,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1003  	.backend_fini = smu10_hwmgr_backend_fini,
a960d61c drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c    Rex Zhu    2017-05-11 @1004  	.asic_setup = NULL,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1005  	.apply_state_adjust_rules = smu10_apply_state_adjust_rules,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1006  	.force_dpm_level = smu10_dpm_force_dpm_level,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1007  	.get_power_state_size = smu10_get_power_state_size,
a960d61c drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c    Rex Zhu    2017-05-11  1008  	.powerdown_uvd = NULL,
a960d61c drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c    Rex Zhu    2017-05-11  1009  	.powergate_uvd = NULL,
a960d61c drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c    Rex Zhu    2017-05-11  1010  	.powergate_vce = NULL,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1011  	.get_mclk = smu10_dpm_get_mclk,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1012  	.get_sclk = smu10_dpm_get_sclk,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1013  	.patch_boot_state = smu10_dpm_patch_boot_state,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1014  	.get_pp_table_entry = smu10_dpm_get_pp_table_entry,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1015  	.get_num_of_pp_table_entries = smu10_dpm_get_num_of_pp_table_entries,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1016  	.set_cpu_power_state = smu10_set_cpu_power_state,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1017  	.store_cc6_data = smu10_store_cc6_data,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1018  	.force_clock_level = smu10_force_clock_level,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1019  	.print_clock_levels = smu10_print_clock_levels,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1020  	.get_dal_power_level = smu10_get_dal_power_level,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1021  	.get_performance_level = smu10_get_performance_level,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1022  	.get_current_shallow_sleep_clocks = smu10_get_current_shallow_sleep_clocks,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1023  	.get_clock_by_type_with_latency = smu10_get_clock_by_type_with_latency,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1024  	.get_clock_by_type_with_voltage = smu10_get_clock_by_type_with_voltage,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1025  	.get_max_high_clocks = smu10_get_max_high_clocks,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1026  	.read_sensor = smu10_read_sensor,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1027  	.set_active_display_count = smu10_set_active_display_count,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1028  	.set_deep_sleep_dcefclk = smu10_set_deep_sleep_dcefclk,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1029  	.dynamic_state_management_enable = smu10_enable_dpm_tasks,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1030  	.power_off_asic = smu10_power_off_asic,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06 @1031  	.asic_setup = smu10_setup_asic_task,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1032  	.power_state_set = smu10_set_power_state_tasks,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1033  	.dynamic_state_management_disable = smu10_disable_dpm_tasks,
c4256885 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c Rex Zhu    2018-03-06  1034  	.set_mmhub_powergating_by_smu = smu10_set_mmhub_powergating_by_smu,
a960d61c drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c    Rex Zhu    2017-05-11  1035  };
a960d61c drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c    Rex Zhu    2017-05-11  1036

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

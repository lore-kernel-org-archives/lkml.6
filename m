Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeBHUpX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:45:23 -0500
Received: from mout.web.de ([212.227.15.3]:42681 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbeBHUpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:45:21 -0500
Subject: [PATCH 2/3] drm/amd/powerplay/hwmgr: Adjust layout for source code
 from five if statements
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        David Airlie <airlied@linux.ie>, Eric Huang <JinHuiEric.Huang@amd.com>,
        Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <1e5850db-c07f-add1-919a-be29be9c553d@users.sourceforge.net>
Message-ID: <c39f6210-e68c-5f80-0867-47a92b5d5e03@users.sourceforge.net>
Date: Thu, 8 Feb 2018 21:45:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1e5850db-c07f-add1-919a-be29be9c553d@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:pkA8sMM+OWa5rTflR8bjNzrjtoryx8bI6H43+9YY+oZJsllDYAI
 8MnrkiF1bFsZJqY5f0n9KKlq8huuSB2I1Dr6RB4yuredi1V0MLdlaoN39jyde/SqLHz76pl
 4cdz2+LsEprfvo4Tw9koqBhFAEZQt88kL/knlJu3qdEUPhF4d1rCyhFC3r9w8bCIXTUf/mS
 nxi2i8kjY94UcIUv4qrrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GduZkBTQb0g=:l/jS25CDmpdgHnxsVHmeL+
 AJXUZEud5Qpubr+xX24CbZYrqkWTN6Yraqj4VRopqrAfL8eT6HiGg0QrhytvYp2rwgvQxINfS
 v4IRwtcD0PJwtT4/7FHEsEUNpkENzyxaLc51yj7kHlchCA8Dv+SzZa8qZTC0BpdynYXlBW8LD
 vwXE/5V/XX/zsqRlsoWCSjMxifHJEDWd+TJlw+OFf6XLCcxeru0yX6LspfgQrOADZurTXESUK
 MteP37+Pwk8jQN1yJ9u4DA8mXgnvUP/LpMiF4Iz2Yx7oQAhnSMEZ6jux6sMGwbMg83mdWs5xC
 jvwoD+4ijCWiBOuJqSUbLspFXdyzdsLPxknK6hNVSrZa2WmO5mDoC3VapWarCpYqiPoX+H2WM
 /IeWH+yj3xK/Z2AHtMQWbpi3BR6lHereBbe+5FKFUX+bd7p7J7x5EJLC+leTWPXOV60f2tDLy
 dgACAC0RRpthLmnLzrM0oqM7M4UaSlxrQRSQpHQx3ZnqvtoQOTVTgcw43kLnHCsi4/emkrCTp
 y7u+LZHClh+82NNg9TbcLSXG4LwD1ZxCIefsh3b56Se7qNjSfLIohjloQFrpfnJrAcV6E8WkU
 bSr+JZwhJD9yXJ3RhfZn/uqtu4hPXcJTteXdonTZjMjkGc1cKsNvo8D9OUci7ZwuaykdVyON6
 /u1ouI5nP2bDx6BhaEUyZ50Mzm6Jekl1ao1gtEi9Ztn5VnycVPJ/97+lfrahTpMX00WUNwIHR
 NSLcV0QG93pu/QVD2o9ybYpl3OtvAIbAvoLQvh2Zsnc6/G3Ribr6kLub736M82zHHK1NkYuVi
 8yyag2uVhnBDYzlow7ZP45CL4qsQ6pXThUmEuhvS9ggbKpOQf8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Feb 2018 21:01:24 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: Comparisons should place the constant on the right side
of the test
WARNING: else is not generally useful after a break or return

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c   | 33 +++++++++++-------------
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c      | 31 +++++++++++-----------
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c |  5 ++--
 3 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
index c0699b884894..870c517f2057 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
@@ -1772,37 +1772,34 @@ static int cz_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		return 0;
 	case AMDGPU_PP_SENSOR_UVD_VCLK:
 		if (!cz_hwmgr->uvd_power_gated) {
-			if (uvd_index >= CZ_MAX_HARDWARE_POWERLEVELS) {
+			if (uvd_index >= CZ_MAX_HARDWARE_POWERLEVELS)
 				return -EINVAL;
-			} else {
-				vclk = uvd_table->entries[uvd_index].vclk;
-				*((uint32_t *)value) = vclk;
-				return 0;
-			}
+
+			vclk = uvd_table->entries[uvd_index].vclk;
+			*((uint32_t *)value) = vclk;
+			return 0;
 		}
 		*((uint32_t *)value) = 0;
 		return 0;
 	case AMDGPU_PP_SENSOR_UVD_DCLK:
 		if (!cz_hwmgr->uvd_power_gated) {
-			if (uvd_index >= CZ_MAX_HARDWARE_POWERLEVELS) {
+			if (uvd_index >= CZ_MAX_HARDWARE_POWERLEVELS)
 				return -EINVAL;
-			} else {
-				dclk = uvd_table->entries[uvd_index].dclk;
-				*((uint32_t *)value) = dclk;
-				return 0;
-			}
+
+			dclk = uvd_table->entries[uvd_index].dclk;
+			*((uint32_t *)value) = dclk;
+			return 0;
 		}
 		*((uint32_t *)value) = 0;
 		return 0;
 	case AMDGPU_PP_SENSOR_VCE_ECCLK:
 		if (!cz_hwmgr->vce_power_gated) {
-			if (vce_index >= CZ_MAX_HARDWARE_POWERLEVELS) {
+			if (vce_index >= CZ_MAX_HARDWARE_POWERLEVELS)
 				return -EINVAL;
-			} else {
-				ecclk = vce_table->entries[vce_index].ecclk;
-				*((uint32_t *)value) = ecclk;
-				return 0;
-			}
+
+			ecclk = vce_table->entries[vce_index].ecclk;
+			*((uint32_t *)value) = ecclk;
+			return 0;
 		}
 		*((uint32_t *)value) = 0;
 		return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index ded33ed03f11..2681c9317d25 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -813,24 +813,23 @@ int phm_initializa_dynamic_state_adjustment_rule_settings(struct pp_hwmgr *hwmgr
 	/* initialize vddc_dep_on_dal_pwrl table */
 	table_size = sizeof(uint32_t) + 4 * sizeof(struct phm_clock_voltage_dependency_record);
 	table_clk_vlt = kzalloc(table_size, GFP_KERNEL);
-
-	if (NULL == table_clk_vlt) {
+	if (!table_clk_vlt)
 		return -ENOMEM;
-	} else {
-		table_clk_vlt->count = 4;
-		table_clk_vlt->entries[0].clk = PP_DAL_POWERLEVEL_ULTRALOW;
-		table_clk_vlt->entries[0].v = 0;
-		table_clk_vlt->entries[1].clk = PP_DAL_POWERLEVEL_LOW;
-		table_clk_vlt->entries[1].v = 720;
-		table_clk_vlt->entries[2].clk = PP_DAL_POWERLEVEL_NOMINAL;
-		table_clk_vlt->entries[2].v = 810;
-		table_clk_vlt->entries[3].clk = PP_DAL_POWERLEVEL_PERFORMANCE;
-		table_clk_vlt->entries[3].v = 900;
-		if (pptable_info != NULL)
-			pptable_info->vddc_dep_on_dal_pwrl = table_clk_vlt;
-		hwmgr->dyn_state.vddc_dep_on_dal_pwrl = table_clk_vlt;
-	}
 
+	table_clk_vlt->count = 4;
+	table_clk_vlt->entries[0].clk = PP_DAL_POWERLEVEL_ULTRALOW;
+	table_clk_vlt->entries[0].v = 0;
+	table_clk_vlt->entries[1].clk = PP_DAL_POWERLEVEL_LOW;
+	table_clk_vlt->entries[1].v = 720;
+	table_clk_vlt->entries[2].clk = PP_DAL_POWERLEVEL_NOMINAL;
+	table_clk_vlt->entries[2].v = 810;
+	table_clk_vlt->entries[3].clk = PP_DAL_POWERLEVEL_PERFORMANCE;
+	table_clk_vlt->entries[3].v = 900;
+
+	if (pptable_info)
+		pptable_info->vddc_dep_on_dal_pwrl = table_clk_vlt;
+
+	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = table_clk_vlt;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
index c6febbf0bf69..df8b3e67307e 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
@@ -1031,8 +1031,9 @@ int atomctrl_calculate_voltage_evv_on_sclk(
 
 			*voltage = (uint16_t)fV_NL.partial.real;
 			break;
-		} else
-			fV_x = fAdd(fV_x, fStepSize);
+		}
+
+		fV_x = fAdd(fV_x, fStepSize);
 	}
 
 	return result;
-- 
2.16.1

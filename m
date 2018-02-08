Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBHUqw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:46:52 -0500
Received: from mout.web.de ([212.227.15.4]:49987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbeBHUqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:46:50 -0500
Subject: [PATCH 3/3] drm/amd/powerplay/hwmgr: Delete an unnecessary return
 statement in three functions
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
Message-ID: <5a8388c9-7d55-0e15-5d36-c3057c4b2945@users.sourceforge.net>
Date: Thu, 8 Feb 2018 21:46:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1e5850db-c07f-add1-919a-be29be9c553d@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:pEuEV7192CLI0FSli/13cheRbIOkWEnyQ+iJ8FD/vFw21efLc1+
 NUFDf1bU4pizIQHW4AzQkL2QPICuA9H7CQgIm3FS8q3LS9dzMNQmKLFY9jellBobJDo0uj9
 +fyb5zh0FWpNQy7x8tYhyCaLX6UGF1FESIvMp1COCwTxPAI0LHV9Yy+ltc+82dj1PLs+aJi
 ppxIY8bWE4baE0sDdWxOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:45/mTyizxtA=:nuzDaFRQPaLHF32idlxusg
 5xP/KcQ6HqMLjUECLO3owvxqAzJNMP4KagOJA+Q6ZJU+lyHZgdKEwIM+TU4VpZfs/KNdIKLZJ
 JhBmK9b6buljOXNwI/tc9/rLoFrEq+Rt4hU1xlZxpA03Zd8dGFShVzpQ2sIpWJ+E4Pw8ct3FV
 dXgBc2ZPIWxZ2UZRhIXvihi+nMinIvFMxNShBkT58i7pI68BOaDGkU8KS0GONsF+QAQcm6p/v
 kij7FdKv7TENuVkXwKxFN5ZUy3C6ZGJVdiRPhFY8TFjHhmebf86SJCHGzFszb2nktcYt2qPwU
 3B9bEEXhVLDZvhrgEavyqivoqnqn4eUztgVrMR98VTz88mbaLUB13KzSdIIvrI60QnY6ULBLP
 THds2235oyHYjhdY5mg/ibc+Hg0zf/XHHddOCZvo9ring9sWyC7NqxjpHYHeizYf4QU60Qmr/
 cm7WhlSvCb5YY8fhU12wM+mCmxq0efDXY5T3GvSEaYtCnf2nJP82W1QpBqt9v5+Ut2T1lx6ZR
 unEiluYGDUj76fj5oumNhSo9VAu5laUe1qCrW1SK2GP3XT03B3Gs2GoC2cq7AYjUWfSiowrqt
 MjG2zG9eL6xOlI6fcsX6MxpsPXgJNOIFhHD0RdPCjM3cdIFcEMfXUgm8FandkbHaoJ/TkBBxF
 C5lKssFXqXQyMOcX0aAXaPZ2tSDhp6xkn2bNc5vhqu+JeXerXdwNXlBRsF0aPMyzIj8fgPPUo
 bT0nBSDvmxrfEkx8g/o1Q0MmeouSGy5bRahMOKW/+lezWqwuU5uCafVfBbmVvKqVU/hvpWXTr
 GF5yRJbw9sNGFhkcJD+UafK8iOu58Ytl15vopuXuwtCNv2as48=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Feb 2018 21:10:58 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        | 3 ---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index 2681c9317d25..e07b32491092 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -653,8 +653,6 @@ void phm_trim_voltage_table_to_fit_state_table(uint32_t max_vol_steps,
 		vol_table->entries[i] = vol_table->entries[i + diff];
 
 	vol_table->count = max_vol_steps;
-
-	return;
 }
 
 int phm_reset_single_dpm_table(void *table,
@@ -906,7 +904,6 @@ void hwmgr_init_default_caps(struct pp_hwmgr *hwmgr)
 
 	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
 						PHM_PlatformCaps_FanSpeedInTableIsRPM);
-	return;
 }
 
 int hwmgr_set_user_specify_caps(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 2d55dabc77d4..fcdb3563d860 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -3618,7 +3618,6 @@ static uint32_t vega10_find_highest_dpm_level(
 static void vega10_apply_dal_minimum_voltage_request(
 		struct pp_hwmgr *hwmgr)
 {
-	return;
 }
 
 static int vega10_get_soc_index_for_max_uclk(struct pp_hwmgr *hwmgr)
-- 
2.16.1

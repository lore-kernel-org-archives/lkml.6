Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeBHUmZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:42:25 -0500
Received: from mout.web.de ([212.227.15.4]:44193 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751700AbeBHUmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:42:23 -0500
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
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] drm/amd/powerplay/hwmgr: Adjustments for eight function
 implementations
Message-ID: <1e5850db-c07f-add1-919a-be29be9c553d@users.sourceforge.net>
Date: Thu, 8 Feb 2018 21:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:03CvmUbQpXQrcn9QspyHZDB4p/ht2b7kwX1fBhOlNrj1u+H1fPM
 1WRcLx2gwVfbvxibHMUW0rvqXIPVE5/PO8cBq+gt/2f4jqxz1Xx93bvNsfVQXB2rQUpPf9c
 KTlQW73zEpmBDJ96sIbQ1r853TdxzyGOEMP5de/47fUQQftS/he/wKGJbMrCoibYrg1riMh
 STjWUNHqttE1cJu3ubNtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XOttM7E6o60=:1rlSV4bmL/dNdOan0sY1Lm
 0mGedLie54XUvehCJgIUIwBKn2LEoGSi+VYqEpfarRduHkp+3OyxEMvFl2nwyQg5RWATw6RMF
 1SITXbGCjyqEKyXfuZMbERbwLMrzq69tPP8cPJDL0HoOx9mi0OV2rIX+jeRZsdFIppYcv+mg/
 7M8jraid8BPH0w/lYXcoqRb4kSUI7WVBXPfWOf3gy/M9Yv5Hhq5p5x4viA6zuC/HJXRYv8Yoe
 AcuGjUcQbPV8QWGsa2hXXRPNnerlH4JNWi90Qm+EIx3YFQ/xNupAhBdSIU9ysy5+EvVtW7uwi
 8frPbAE+VrcaRx5gsxd4E6jdadavDLk41EJqI6H1dDv0JZIQvArYheC9QP/ee2DucLkVJVAwZ
 hLTQStOaXA0kpDymKgDlnT0K0maGF5RZ6EL+uMraouwQWVWRGFlckEmje/p9TMtnxPR0oPAWQ
 PqudNZi8cSkaWkwFz8IIMoi0lm0aVmZs0etYP+esI+ai8ETTFNCek+zvcum+H8x7pWerXMRzn
 a7z4orMrXB/TC52KdO1CsjCTemInI325TO3Q75UN41Qk1Y+kNAV2oMk5mM2d5cZd5j/tZUA0Y
 54aru31w2PEZ8ltBY9x93HCeXIl9ZcaXfCr0ddqRO7T7/crPVViTsSfX5LMc2JFuuctqTLOCP
 f6+u1bOm4wi2+USVfe83Yhej5mjKLQKELjQn27+TfxkEd6rzDqog2sdhXj7ZUnrSzUyFYGhQj
 6LDidTTaoFz0S2eMcWvgNjmsG3JRv0JOCOef6PK+biWrWVSVPjDBuScAOUbOrMdK19Fy87h0O
 ICOJR3DotonX8gEv4wGm9lQXzzxa7hwAYeJtUBtJd+msabqBUE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Feb 2018 21:37:42 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in three functions
  Adjust layout for source code from five if statements
  Delete an unnecessary return statement in three functions

 drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     | 37 ++++++++++------------
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        | 35 +++++++++-----------
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c   |  5 +--
 drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c     |  4 +--
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  1 -
 5 files changed, 35 insertions(+), 47 deletions(-)

-- 
2.16.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeCJVaX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 16:30:23 -0500
Received: from mout.web.de ([212.227.15.4]:42419 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeCJVaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 16:30:21 -0500
To: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] wlcore: Adjustments for wl1271_acx_sta_rate_policies()
Message-ID: <b5db0825-394a-1d6d-351a-43be14e4c6b4@users.sourceforge.net>
Date: Sat, 10 Mar 2018 22:30:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Ci7vqf3nRAUHobrfGxuOg0eHWSC+jyJrRe/icnDmjp3cFYlm/8o
 Wg8Rtr2SQQxAZYF6wdFWsRzk13zzT0moK3pWg45RgUNYzXyruC5+KA87YVAZIcl591GqtV+
 01Px989EBwn66JYg4xuFRw1htbpaeSp02+Pr1fB/IwPoapOM0COjfCF5h2KtGKJOaSaunS6
 MczyoWICojjLfL+HEu7Uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zcHSfBJp0W4=:x5Iyp/G/0o1Et7FyVtZn28
 FCMtb5pS0J3TUc2fDRyuYU0uTrGa/r4AHkOrhRrjV7Cfnxt+VN5yi3Uit7tul6w28ZjPFLJcJ
 cvvVnZgNKcigoHjP9dY34UiPb1aCZdOxzihjkPOeX7zQRXzB/LsOCcQ/0k2f3iHbZBD2wIqXS
 b61TJgFW9SapuEX4vOclRENybQ5sU7jixjHj3fPoe1C9LQHW+7xSW1tHRxLEIq6SfEVpoyonM
 gn8AXu3inv/us2og2EK6Gu4tGlSAF3MfKiLBghWSyYGwh1FQnI0ytIIjsdRI3VoBHHv+mCSd/
 n05TxXqlN6zjTqrddx0MHVirriykdnf8mm/pHMYlxPyN8ZklJ+Ixks+6DnEBb31zah3pYL3W8
 +livWOijwdZIAF1OGW3aTJQErJM1J3vCZF8HPHIioivjWOwZn2a8TMjgfC9nn6QSr024Oc4o3
 AyjbYqWkDgOwL+hz8zj+dOkdxvWjJjNlYnZXFdZwoYwCMvQNCiyaVoqtDuzANzJNnetGUSl3f
 a4YorW/DuxpPJuD8NnwIagMIdN5zcUt7K1UZ1fmgGLrIqdc4gwJH0jsZZDBQJuLaenFdV+Cd/
 QMxL8s2NrUcBlTJpq+YESCA6QBdIXKXj+/Y9AP+xUNacvm5JhNaazy0Gd73Z1tgBFcWY3OggC
 Cs422F0GVdXR54LKlcTmVTZHqKuh9GTctoMx5dDhIJ95MRH4xeGp4D4C8MYIur4+oM4PUyDKj
 12kvsQR55Ndng5xPMEGU4/TiFtTEdE3TxwuJaCaB9Egcx92Klvx91zZhewnU+Wf6qMFJ35BAT
 GBU096Ndqbug6KskGlOOTuSIXtNFzEpQZhg3nqSu08BbebM9AA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Mar 2018 22:25:45 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an unnecessary variable initialisation
  Return directly after a failed kzalloc()
  Use common error handling code

 drivers/net/wireless/ti/wlcore/acx.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

-- 
2.16.2

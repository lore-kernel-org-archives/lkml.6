Return-Path: <kishon@ti.com>
X-Google-Smtp-Source: AG47ELtSsPjE1HurZ6SzOyrVlxu5LuSZ9tlkXMSUw0dBZAPZv9Jgb33dE9nBadbeo/aAyzfruG2P
ARC-Seal: i=1; a=rsa-sha256; t=1520849369; cv=none;
        d=google.com; s=arc-20160816;
        b=iWOgcgINVC0ZI9QPxp1E/Kq7kqshQkdDdHbKUSm1eqrAKaGxqujM+++thDpBxxYKot
         FacfB9rZjr7xAM+MePhLr5Q3cZo+FmASEf1P7bJw6AgMchrUUqgONk01wIQ5cxyqJcla
         jOrYWlA1MiBJBPitwTxXS07wGqd9ByACo+zBygK9fZcqX3kv/KqgSUBpRhOOyYMYrmUP
         kIznHWq+lwaLd4RA7yznOpoqdoskGUyTFNWLxxBwqjWawijuA/frgpwAFXxTVp6H2raK
         IhhdXs2/Yf60Y1r4YCUeMJERkGuvJ1n8JE+eDD9gkc15fiPvPVsb009ZWVeUkTHwAo05
         m6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=d6sJ94V96qYjByBUmtpuhhYtT/W2aTKHaJoxpEzlLLg=;
        b=shSa+zfG9HsJ78h6M63zLTDsK93+UHqYusyHJgIwZSjT/M5iGjZIseXHIRGi61qzlX
         +vWrGsXph6cKV8np1AfwHiZ6aKqkID3WSkgW5DPZ07ZQab36AN0mPJRXNnvH0Fps4NMF
         a0KtIq2Nw5cyuFX2LkyCM4IUvQJmChMv8rzfnML9snvGEVSCWOI9YJNlEfeCZyB/lh7T
         1G6M1XUOc+KuKRkDm8YOjf9yhIFwPTxStitjHjujaz6RmNVc0e9uO7y1BrPf7P0i/vKd
         MKBDEV5YhZ7et7XBJXck2DLsUK6jhbbJxJCAU1RptXR4SbPXPX95zK3frOtHI7pEKcBZ
         RX2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=YiieJS3k;
       spf=pass (google.com: domain of kishon@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=kishon@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=YiieJS3k;
       spf=pass (google.com: domain of kishon@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=kishon@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <gregkh@linuxfoundation.org>
CC: <kishon@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] phy: for 4.16 -rc
Date: Mon, 12 Mar 2018 15:39:26 +0530
Message-ID: <20180312100926.24876-1-kishon@ti.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594726148608527616?=
X-GMAIL-MSGID: =?utf-8?q?1594726148608527616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Please find the pull request for 4.16 -rc cycle below. It has a single patch
from Arnd for fixing Kbuild failure in qcom-ufs driver.

This should help to get closer to a clean 4.16 build. Kindly merge it in
this -rc cycle if it looks okay to you.

Thanks
Kishon

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-4.16-rc

for you to fetch changes up to 59fba0869acae06ff594dd7e9808ed673f53538a:

  phy: qcom-ufs: add MODULE_LICENSE tag (2018-03-12 15:11:59 +0530)

----------------------------------------------------------------
phy: for 4.16-rc

 *) Fix a Kbuild failure in qcom-ufs

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Arnd Bergmann (1):
      phy: qcom-ufs: add MODULE_LICENSE tag

 drivers/phy/qualcomm/phy-qcom-ufs.c | 5 +++++
 1 file changed, 5 insertions(+)
-- 
2.11.0

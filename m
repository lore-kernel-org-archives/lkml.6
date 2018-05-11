Return-Path: <pierre-yves.mordret@st.com>
X-Google-Smtp-Source: AB8JxZoWVADwezpH1TPIQ4usk8Jyp60GDhFbkJ9J6mJaM7uXH5aY7ii/YSjBK7viL9uPU5539PNI
ARC-Seal: i=1; a=rsa-sha256; t=1526026987; cv=none;
        d=google.com; s=arc-20160816;
        b=r5TdQAGjSKcMqfCQDbnsW7/0bBdQwnxcANJ5t2zWeO9KP8mRSbZkJxNR4lNBaSFPmX
         XR94HEm1hiGzrUzk1LQTth8p8UbVQ8WCt13/eetZo+cAt6oc9UW2n68K985pfU//oI1c
         DdkgCgQL4EpiU6eAgRJTPRdY/y83elmH3bjUTDcoNXfgQPa+gCtwvarCFNc2di48Okl6
         2BvPQiajhiA9bzOfjU4wA8sAgytPfLTpE7Wkh2nHdox3a+/XmjuuvWhhgkl/CRC4MLCY
         DCjWC3+UHB3AqewK/Gpz0YW1KjIKa5E+qW0EMxt+5b1ZQkur29OnK6OinDlrsQW+9Ero
         uGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=R7U3UF/iktEEWIJTxjzB3sri2/s0c/J5l8H5tEDZZIo=;
        b=hKJF5tA45aKpXOs3SEmN2hrgQySG1yDn7b0YiiZuwlGlwFo12AjVVu2jJ3KtDk+loq
         p8mfzDGywItE7LVnY+SUtlD3tLiY915CFaOTZp46LN4aVMWOTardJA94i7645lAec/qA
         SlwOco0CqwlCN6DN7e/ddTuOiwKGY/nbM4MAijuI7eHV540WaAY1b2DprumFS0H/dPsL
         A0wpHbV8/sqgK9r4K00+/pBiWBFE+Sc7ApVJUAA+tsNXGytKfj7xsTfgWoQnLt10pMHc
         Xw0dFLpPtMthZdnV/kUPBAx/aRvFkQoZqAWoU0pR9SmRoqKnrylGEl8jOe+UqSgU6R+T
         I+uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pierre-yves.mordret@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=pierre-yves.mordret@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pierre-yves.mordret@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=pierre-yves.mordret@st.com
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy
 Dunlap <rdunlap@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH] MAINTAINERS: add entry for STM32 I2C driver
Date: Fri, 11 May 2018 10:22:39 +0200
Message-ID: <1526026959-3255-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_03:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600155274523087044?=
X-GMAIL-MSGID: =?utf-8?q?1600155274523087044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add I2C/SMBUS Driver entry for STM32 family from ST Microelectronics.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 79bb02f..a0e597d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13275,6 +13275,12 @@ M:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
 S:	Maintained
 F:	arch/alpha/kernel/srm_env.c
 
+ST STM32 I2C/SMBUS DRIVER
+M:	Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	drivers/i2c/busses/i2c-stm32*
+
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	stable@vger.kernel.org
-- 
2.7.4

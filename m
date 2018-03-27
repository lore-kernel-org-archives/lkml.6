Return-Path: <Rene.Hickersberger@gmx.at>
X-Google-Smtp-Source: AIpwx48F+N9MTwhZsnSvvw2INPoQHkBNMgVvCdm+iPA7mBnqt+Vbqj3Cj7C2LrwK+qRTKV+qpNbP
ARC-Seal: i=1; a=rsa-sha256; t=1522167306; cv=none;
        d=google.com; s=arc-20160816;
        b=x0OVC5ahpMiSPC7Mchpz5wEtfzrWYOymEzolCx+EzJs+oF4kaBTrM04iQvPJnCCUoZ
         N7jlR+k7frW3rXSkJPWf4IL8fE8GNvn1mVohtOZJMGRuhZVMXyNrD9KmeLwkYgrPkqOd
         fnPe7tRBI/AjHKiIVXp3GEMOMmQg8HTsxixj654K6Y5NzIpMJ1dO7efTDYVgKUWUpbTd
         zL8PzmiQXVv8WhC915VKxYSDGKfoQDllum8CXhg45eDUuPA7+UMbUfkcTA6HGPX3pWSM
         pyowhhtNSz0OikJXa2Br85tITo4qhmY2UQuFFXQA+DN88szS0agtR3E2LjUqS0O3V4aI
         4ybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=7xlZX9o/+82lrzuZ7I3r0OpOIIuTZ+m9pR81eaTcPM4=;
        b=CxDxJSb4csDjNEmYbx4X679C/PfMV6tFkkJOTQl7uLE2xU1APJsJU3kcaIt5iYCfKx
         XJc9SbssWe+qAv9d7z/6fKoGynjhhPwitBkjw5wZfIZ5IL2AfGpuTT9hSYu5n/AG7e1w
         YMBL37oTXdbzWuEHFBAzOmRkIC0BuYQiXNnLCUx5Rp1ncs5OYqNJqPiaYJKhF+mzO239
         WS7FSFsNNpgFQFyuaoolDm2KW9++gkanjbyMDrcb95ZBSCIOccvrZU2NxW6UXbj0AQCM
         kN2E2yCkzX8EQiddVKFpktARgdMCSy4ZmTVyTE/+ZKLcRxbAe1M22Rcyzi9Ib8s29KcJ
         20lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rene.hickersberger@gmx.at designates 212.227.15.18 as permitted sender) smtp.mailfrom=Rene.Hickersberger@gmx.at
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rene.hickersberger@gmx.at designates 212.227.15.18 as permitted sender) smtp.mailfrom=Rene.Hickersberger@gmx.at
From: Rene Hickersberger <Rene.Hickersberger@gmx.at>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Rene Hickersberger <Rene.Hickersberger@gmx.at>
Subject: [PATCH] drivers: staging: rtl8192e: fixed a space coding style issue
Date: Tue, 27 Mar 2018 18:14:37 +0200
Message-Id: <1522167277-3697-1-git-send-email-Rene.Hickersberger@gmx.at>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K0:BYMwGI40NMIU4Ln8J/CfRstNVbdX04kTY8HjSsnz4ZlxabmxXj+
 zkRiJXjv1VtKtjx/CtQ3jjSZBejg/LBNuDQSjEO2uAZVeab/9s7uietp4vaPcjp2uJLKw5R
 uwdyNppyAt+wwFWTq97GVkft/uIOvGaOuXvEXhKcfvfeCmg4QI+q56JMaqclgTn3dwgSo+y
 h1iJkGLo8MoadJmSmOaPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nbtvQkkK544=:DUceaZ2CKFCyxsOUydc/LN
 g7Jwb2ttJI9tsXRpt8vByuL3UQnQiy4+mTYe3V/dA9pm2GQBjfgh9jkk4kVsDAUskZxxeYjZp
 3ERCUeJ/H00SnUNrc9JXDo+nvYlTro2ojlBsim5cb9BSs0UNxak+TjQUuP4pnx2kIfsgQJ65l
 kYfQyr9eMnhCHgnMOTX4Uf09lS9w1anMarDJGs+KUe+Aki83YOvOBz/rbLpxo3poUKiY2bQS9
 e++MEi5DolPDm0rZKgfVGPL5SegndxerrlEkoccxp5gXk72SvQ8dOnvfBsDur3n+XvlkyfKD8
 k5Y0uiiT6/3cJtRp+ENbISmqdc9ST7Fn9545Z77QK2gk2KqffYgsVf8Unqp2cnIsYMgXigjIx
 4G/1q2nyy4D+zfGICY+JHxGuWqN1LmFC7cARdLDOtYcZg0GbRVO8oq4+b2lVbHzHhKOx0Sv+G
 UtvyCVDZmywdP1YvmKkY6ZUk2Tpdb4azVjgOjBpxdl4yNCOhfKHylD1mHP6ed/rpEim/xUtFS
 HgHXO+7ZOTHuaCaZuuhL7C9aSIisCs08kt2Npv/zb9PT6FezHmhzHQtCLCU54r/naT4yAxSph
 oq5wBwoaN50qpJkUolRtCMum5CattVuljMrSkIEB10cZEcpQL7zQgS62jjRnMqRx+4UETzltC
 RT012rSKfLs7z+A9OMGQb1Ec/slvBZHbSib36A8bhTjM5YtwZkgKeiJQ+QN8I48Q2jq+JM4vQ
 Pbp817R80jIv9YdYZGLMpaMjxPojAz0BOB30ryyXd6zW86sSGGeBT/LChCKDdv/2fxbWn8dnw
 MMDS7fVi9+DcuQgVnno149NnYIz6w==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596108106120612758?=
X-GMAIL-MSGID: =?utf-8?q?1596108106120612758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There was a weird space before the struct which is now removed.

Signed-off-by: Rene Hickersberger <Rene.Hickersberger@gmx.at>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index eb6d841..c466a5e7 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -76,7 +76,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 				    u16 StatusCode, u8 type)
 {
 	struct sk_buff *skb = NULL;
-	 struct rtllib_hdr_3addr *BAReq = NULL;
+	struct rtllib_hdr_3addr *BAReq = NULL;
 	u8 *tag = NULL;
 	u16 len = ieee->tx_headroom + 9;
 
-- 
2.7.4

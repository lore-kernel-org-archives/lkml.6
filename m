Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/GCcfZPnRkX51ZHZEYocFM36UCkgmBXVSUDYtidjH0afF7TSZcTkmKedMXjxhObIlFkdaY
ARC-Seal: i=1; a=rsa-sha256; t=1522393771; cv=none;
        d=google.com; s=arc-20160816;
        b=00n/0rfQ0alW1cW5QjXRMAtw4ylbZ/Bf9V5ZzR72ZRNCuDdkHAm5tPavUuVLlVvxT0
         SguXzyFycyihgEkQaX9vg0IhIa8y+1Zvs3hhloV/mTZrtgXhGd1JGJeOnYBBqLVf/Stt
         3SsxmeoBbNPL0nmOp90cgf0K+VBzhUdPGiOLP4EpWe1djfPmv3TbXy89F0kFwzKNwHiY
         B9ZO/X6hpS6FV8wmokZNQFu6Bo1vcDbkYp1g2SaB/2OIlm0djmotkN0+C/eeiWjYAP10
         6eaVrre00QKR0UfXcpcuGnQyFoWE9tJ0X41Ij4UT7DmAz02DKuDC6PLqQ4ZT/mSVmqYK
         owOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=kB0HZN5eVdCoiKKFJfsrqWHeoSyzwPLohai+7lDr+c4=;
        b=k8jSxh8JKMte5C2KA+xRaWEs0SXYk13OFESLoH+0e5jQX8mYKcAfUPnJKD5237gb5Z
         a0iy1+kZJ800RomQo8DnAzH/l5rderShWV9/JrNbyyuJZhA3GolQ1LKN9ceTtSfo87AU
         xX6ZXfHQAREZ89+tuF7eyQsYu0fmW0FUBhPfUHWYOguxz+0YUZYOtGgvHHzs00TdkblY
         kcj1lGqisTR47xhtlsbjX6a5QwdnEJx4evv48tuSOnm8qOgks6QaKgMyZTMH3epg348S
         /ezDiOHKzLqB2t2Dr3UZFB0bH+DmfHdG8oFKCJoOzxj9CMhwBikQ6vOtIh2PcG1bVS7j
         60Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 38/76] staging: ks7010: Remove trailing _t from 'struct hostif_adhoc_set_confirm_t'.
Date: Fri, 30 Mar 2018 00:08:01 -0700
Message-Id: <20180330070842.25224-38-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:onOhpiG/t1VtuXGik5n1w3JOp4J4cf+RYqsQr9rF/Uj1pRTeuuy
 mRMEafQQqsQBXEVMHqOohzhW7yiSjJ0NdumLKoVo9/8IprgESgoki2+oT5GlaJqfyMRbc/M
 Uo1hW1Fd86kb/gJG/xX/b8+Nj+NYYe2GPFeGUItXM2/z+HrxdGn2Wxg37wIpCPnvj72/7dw
 Y5GHLgBrgQQ/s/NasYGSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GkByyGDUVlM=:W/X09hnX8QqQfgRr/AqUKs
 kf6XAOjIF7GGffvpvhWyy6e5pUvYvl5UClNqnpRX2to5zT0eSZRc6kphLpYuEt6yD2LLZu9d/
 CMfFx1hKueJ1YKFOHhJibRw+5fpBeCqOOYmGApasYjN2UssE7kUDTKYyn0RQtZZmSiPm/BoM0
 /jfm06l3DwDY5stF3dGlHoFZ+df49S1gk8DafBLRHu2dMDdoEXT8lFYKUFtvJgzrp2myfGVFE
 qH49U54AunD6934n40vRbZqdbznZ4DYO6I880B/elY90LjLYMaY4fWuh14PgCTA4G2tSQ67h1
 iI6e/8UsLo8LHeocDfFdu8eCSFRjXhegilI/BPY+a8Y6x0OpI3+49KP+kYh7VV3lhF5sZX/Mu
 gBzLfGcxMGrDCqJF8mt3ZxuZQh/FYOmhZMZetVDeVxbnNk/ZfuKLMG2UjhxJDrUwMAaSy8mXB
 o3z8V6p28fUnP9yCJQ2bhq3hJVOIZ5nFECMaIEKstxe7upyrLTVqp2F9gmIN1SHIbqvB75lZe
 baBJvFnQFkeGZQwhphUYCB6vynwaJBdo8qRLZnFPGNvII3V+i7GSoq0N0DE3T8XpfrW8xBL+r
 FbrAuXxevDV0h5B/vK4AuXphdFn1qsWkL28KN7xVPdplMSGffh1ZWzp/vD7mjfv3AQ5hHZtfu
 jUs98+XeT4EKepsqJhy1NDoUsyflQhjLpk01BmVs8zyftD/Ehho4x0Dp7LNnplDJr36WZViY+
 XHEJ2/0wA/TL5J/zXi1J/CYxGfg0jG+Q9+IvIA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345571112922989?=
X-GMAIL-MSGID: =?utf-8?q?1596345571112922989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_adhoc_set_confirm_t' with 'struct
hostif_adhoc_set_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 9ba350ec64ba..e599ab1d9f15 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -424,7 +424,7 @@ struct hostif_adhoc_set2_request {
 	u8 bssid[ETH_ALEN];
 } __packed;
 
-struct hostif_adhoc_set_confirm_t {
+struct hostif_adhoc_set_confirm {
 	struct hostif_hdr header;
 	__le16 result_code;
 } __packed;
-- 
2.16.3

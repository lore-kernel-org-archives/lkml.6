Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49f9IRAV64CGonFoQHoyWyCg+YpkNHO6TImy6A0k+73Mxe0oMJYnebQR9/iNWxlnjknRr4f
ARC-Seal: i=1; a=rsa-sha256; t=1522476567; cv=none;
        d=google.com; s=arc-20160816;
        b=F8+nBz9oQX2tTP0ASwkeEH23gVkUiYTWXI6t3fwZsAgq+gOVWwCSRZhweRL5ZzBcyk
         hZ+CkURlaycb6C1am0lyENkLnJbdJ/7niQnQ2OHp3AukL9f8FnJpMMHAWwG5rH8IHHfB
         gzZp0ZMz5uFioKmb1wdfssoWXXVBlRMSf6OdHs96PQIyhWvISJWmh38PYSHb+ZUDFb7t
         ozuktIuiB1O0g5ZyiDs5mx1UqkGtkPvI7lpLhK12BtIDOU1As2jsvskeAWUdZdQ0WzRQ
         7OVru3MuDyCurrv7hPrWftdFrElna4Z3r6nV/xP80rODnEgPOQaQtB85a73BGU4WAy+x
         qEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0yztiY9ZYonWtiSzPAGPcqQx2iR1uMUUhUmFftYFGiM=;
        b=FZ48JwyCDz6dGSjlEwiN6Te6QOH/EwgH1KNplxEizHlCb414CFd8+hdUYb9j+mJOGB
         5Ko3E4bMpwdjBUSO4ZBqFOoliKvVPcQ9JK6Awdx1/Wo96TtszQzTX5KvtVUlTaYTmuRB
         1S60JNbz6aHYQzOua5r5zs5kd7gOR+Kdz6rAhDukLD7oOYRCmbvQsMztgYoZMQOs1RB0
         XQbUtGVH2yFIRioCrhv4S0e+gXg3WcF7Gi8F7h1JPQs0BEudGPwPwlpptlsfFCEkR1x6
         VziK3tUMtYRi2lQt88PVuHm8tzQMjftldzLBB5Uknkt2EC+vBfizPBtLJg55gCgTtVUx
         q9TQ==
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
Subject: [PATCH v2 06/75] staging: ks7010: Remove unused 'struct hostif_data_indication_t'.
Date: Fri, 30 Mar 2018 23:07:46 -0700
Message-Id: <20180331060855.9452-6-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:2zsLPtJilxU8b2giDimtkW9qp/Vw+4AdRBPYWN7X3RbusBE/c/1
 H2clz/kzEtnZO8A+/1LJ18LjS+LqYxXBYqbdFbML1DWHY3A3sxRT10eCwQmrcpl/PquoC4k
 9CTnS+fbC2RJdi81UyyBjy2hrL4tSb2IyWx8MFv+r84rIuAdHcrubnvM3asfI17Hf/rX0Zr
 P9CXhsPlFRwovAot22Etw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kCrpLTckLbE=:J0xCBhQN1sQ4sEqgjY3qX9
 iXolquNlVkOi3e0nIs/0+imYCR4sdrPl3KaOUaQnAllWY3qg7PDSOTIitT7xd/I/+xWMJ0jpK
 aTok/7f4Wx2paPQ+PlYOPkFP/GQjSfDKIjrbPNSNdz0I7UKux5XQYDd4mflm1vDHLhpc/WMgV
 VTS/IdMfQ6k1pnWYjo+aq1Y9CQfIk/jgUdvWcVCWrHcT1x0+kdvhFV1QktqI+S4EFzkrfeWWj
 w6w1HQy3q1vebSQuhpmNmnyr0JY5SwTrFY9D82hpTCwNFSxJi3A98OEnuiR42Zb0f4co34rNf
 WrLaDxV7k26mj5JQXrdDHu1XhILn4EEBRDEznPjbD9u5Y4u/WDxE0FLgf9EcG7DbMxpepsObY
 Y+0pMR0GuYPPMhmWXant6bLlCXTlvh/x/7RVx5AmtnbsoDnHe3IyYHPMqr+0J9AmhAPYgGpUj
 jDSRlHaJCtqGX8J95/iH4TGa1o1sriEJIz8BgsQUGmNho2aKPIJ7Q4wfyAJ7Bc+R9Ts54hSsT
 isgeDiJhQIvLyA60Kh/V+zyA8AdPemGHCzjl3TTWVZ4eGsX4v8lQuMcQTks6ZkBDkC9JcnyvT
 F1xEx5/3TkcovQopVkVeI9AJHICa2N4cD0LZVxwFLgNrKEx+pGpuWxsSfV5UUzkoYbD/DE+mk
 iwyIwuPcvAps1v1X3pXvpwGczGQyz6DVjwMIKYojcTmFmHu+UkUtqybM4b5t5q/Z7sssTFi6Z
 +u3/nGp+/YYrOVh/43mBLo+lLTqtVQ8ZkXwBsw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432389710019808?=
X-GMAIL-MSGID: =?utf-8?q?1596432389710019808?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct hostif_data_indication_t' is not used in this driver. Remove
'struct hostif_data_indication_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 036758687b7f..54084af8dcea 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -76,16 +76,9 @@ struct hostif_data_request {
 	u8 data[0];
 } __packed;
 
-struct hostif_data_indication_t {
-	struct hostif_hdr header;
-	__le16 auth_type;
-/* #define TYPE_DATA 0x0000 */
 #define TYPE_PMK1 0x0001
 #define TYPE_GMK1 0x0002
 #define TYPE_GMK2 0x0003
-	__le16 reserved;
-	u8 data[0];
-} __packed;
 
 #define CHANNEL_LIST_MAX_SIZE 14
 struct channel_list_t {
-- 
2.16.3

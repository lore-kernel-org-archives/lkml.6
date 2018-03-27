Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELtG8QzkYzjLtR2495E2LXevgqLx5VD2YWX7urh/KL8mTvJh7UTlrc6Lw7T4gbqk78NVnyDr
ARC-Seal: i=1; a=rsa-sha256; t=1522140094; cv=none;
        d=google.com; s=arc-20160816;
        b=r8+KHpcowmT8wwZeTeuQHzh3rj4bL4L8n0qwrGaj7ScmhANdc3mVMNOBpT5Uoh4ha4
         1JQW/KTILF0sLRspskxqSKPI3BZIFbY1MK1YHmpVXu0yKkeeawN4lKQM0KGGu7cG2hke
         gbqsua/1AVNejY0JGjS/Hms5NGWG5dWrV9Q04YhSN3cS+VDvLodn/PK9MjIfA3UtQEqw
         ccpZ5MrEd4d4ApxbBh6bebQHPZMWDtPycLRSpyDVU8uLVze/GnElbpUPNkefaavgm+m5
         pvJKBvLRCI0/Vbl92GY+sPCPIA24gEmllLtT6lwYUpiRPhwPnFITFC7dWATC7izc0+W0
         KPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ySayShPdXHOXqa+AIwezTTQqZBqVZKVdbtucmNURFF0=;
        b=yvqsgQi5yuR2A+cwuAXNkxbK/246xx8wNCn3D1Pwdx5XNKhceDFAFuCt29xQiRfGmc
         O+W5ybo1/nb1ICnfwkJmQ9TQSn/g7Heh33y5ENVfA6bDmpOu1EJB6vkq36SXcZcmmMEm
         C/3no2b7tIDq4Kguh5oGtssHszFFPzO+Z+AeFp0OGkitiTB1wB7COSU2Pp8qZhJfzPpB
         FUL8Kw7e1czbMsAbdeyo2Um5zWzzroaBKE/sK5dBOQsob1oxzZtyo9HvOkp2WM/LGGGQ
         dfhG7d/17KAeQvDHF9w9V8J/aQRsQoPFbKsByi+xRuPdw2oCXIJ8ULDIvYTp4who0hD8
         tUdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 13/23] staging: rtl8723bs: Add spaces around ternary operators.
Date: Tue, 27 Mar 2018 01:41:05 -0700
Message-Id: <20180327084115.16129-13-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Am6T6+C0rW1shgSrhQCCT0wYeJIuem3mRINNzbBkVdoYLdFJh9/
 tS4c6XwGkHPlKMId+PgjZvEKf+5RhKuChZaV1sekq8kV/NyNf4CCQJgHtftcbT11yTzz7E4
 9pLgMvWCJdiKLirnRTMPQVF6vcsujY9BlkvQ6UM6JXYdXA5RHbxbJT2AA8jBf8XkGQm9DPB
 FVP0bU4asCQUs64B4CP8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sgBDvjAgswg=:kcHDLKlPov1sAmdXxkUuc+
 cLGmyCPbg88GxPmQkUZdIemQb+ouaUTPhUrjHi9AQE5iK3m9q+YRd+Q//wuHr8PnFWTEw2J+h
 UKykw/5plub9ZvXD9OnGR6bTTNjMpyt+zJLkMnXR57G+H6ROlk8BOPicX3fIHtdQv2J1h/mn8
 u+LDTHlKaCpCJ6Mwdr3k2fQwk3mxnt9R32Ruwfwl+j3wuNrihoFxn/40qzG8uYfRl/hN9o/CQ
 9Krq3R8N5ptLCkc7PXCaSIXFUPb+Bq4CTtKipkQ5hJUC1n3ppy2QnJJrb4DmRhxhotbnCca9n
 EXZlDOqqi8p0YJEGJ4MuhsHlxiX+x26tUvxD7bkFyNb0wxDmvp9h5iKBobuyj8/bouSjYaffk
 XnWDfrQ2lcxlitypEt2ac5lG39LQKAU/Tl1EoKcVKd6wj/5naWfkaQrx3p8BjXsUcZkTHVN0t
 6I5XIvTXIl1j8XBhuWT9kyoaKAV5zHhUNTui0wYKhgiTvP0px11nkdF9kXxg05HZBQJ8eOJLE
 1YaqzWrO2d9/uMqunX+rD15s7SsVNTSeQSTTv70pPMIMrBDtGSi1m3Nc8jTXiDETaX5iW0QfW
 nDVnRm0gvdgxTAP4vmPvpwtPf2qYhSRx4DuCQtQza4YMXbiAdMFljaYgVZc1FJjlZrmCA7/bh
 gs7WmpQvI0U9FNcQcWsHqelal9Ge6aA3FLWfqSpQ51xZ279M2xov4ir9lj8+33dWS1XDy4BCO
 eRSDSmeLviZcwvA4h+tCgKd/mA20t219hwjNhQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079571181556502?=
X-GMAIL-MSGID: =?utf-8?q?1596079571181556502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Linux kernel coding style calls for spaces around binary and
ternary operators.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 0e30e984dc1f..9c2d6dd0130f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -48,7 +48,7 @@ static void update_recvframe_attrib(struct adapter *padapter,
 	memset(pattrib, 0, sizeof(struct rx_pkt_attrib));
 
 	/*  update rx report to recv_frame attribute */
-	pattrib->pkt_rpt_type = prxreport->c2h_ind?C2H_PACKET:NORMAL_RX;
+	pattrib->pkt_rpt_type = prxreport->c2h_ind ? C2H_PACKET : NORMAL_RX;
 /* 	DBG_871X("%s: pkt_rpt_type =%d\n", __func__, pattrib->pkt_rpt_type); */
 
 	if (pattrib->pkt_rpt_type == NORMAL_RX) {
-- 
2.16.3

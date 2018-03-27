Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELsDSLU8u23BVYKSaM0azsKbQQH4DtgCkm6wIJq1VP/SA8FHNzoAWI1G+Cw4ZXG9hSPHiZd9
ARC-Seal: i=1; a=rsa-sha256; t=1522140093; cv=none;
        d=google.com; s=arc-20160816;
        b=rtR4OiIVQUg9qrA3WVQAoNgAv8SfzqViWI6wVNNT8TR47+FTEzHayKKJDqNJh5TR4s
         sgPmNAV2P6IzBS/smHzGkd15LQoh69/WKidPfj7HGCWZ+/gtoLPHEwY1cPzO9j8GfjLK
         kAiS22EtLkSLJtKHC9B+QC6lqMg91S+2hPLFM9FAhnVBosG5DdnACaSG3/PtscaB3xk+
         bAhJ0ai/G3TKBKUaVno3FgK5Hy7RaikFZ5cY+vDqPLsvuVMjlJPsoQIv5lIxyx1Yc0Li
         CzS0Srn0sQeuYGztOiV7yzJOZhAClV4R1MqKwxJkbJnEnqY+VRz6XMJCJglvNXDRO0Pw
         Od9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=BoFQ608KRNBgP1/5yACfkVyn0Mxticx+MLZWZ2DZgZc=;
        b=tQXeiNrcI4qTXRzchp32IUxW9eisElqpg0/KU+C5nB128tu0H2onFlKeKbXoCOTQrN
         v1O/R2QHqygRWnN9LMFi4mZb8UuzfaGaJzX3xNh5ztX7SG5xR5Hp9mauK1AAIgXLs5bq
         6Nx34q8hVwTO1nRplnN8vRsziVq/chxc+m0hpg88pVGVv1cNMfGfLzKzVxkYefQYvJvM
         Fju6PZWrSegCouMWb3OzAUXq15mfOaJQ6EkjpoqBgYGxdIcruWYIVuyfOr/UA48QWG/B
         sRhJyFXcb/Zb1X/LpqmnRKYPOn4L7C6tdXZnKyXkJeMStjb4v8Pbz+Esja3ctp61OVnO
         FZdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 12/23] staging: rtl8723bs: Fix lines with trailing open parentheses.
Date: Tue, 27 Mar 2018 01:41:04 -0700
Message-Id: <20180327084115.16129-12-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:S5KGs4kYEImYF0FrSbJDlxLvnZtJAFBZYsxTiYBiXOUBVSX6hf0
 PFGjnvt7w/GcCxOQjmXXfsnfndwVNgZZ5hc98pmrMWQZq9MqED6ClvFKUMr9Nx10WSH2UNu
 iE6FkEcMQRr+FRCOQg16ihLkiTx2ei4UQM6rUBUF0n+fVXT7K7PnVvEFLbGtR+jb463/YzP
 /z3Yi0f8enpbgXj2EsEFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M4WzJNCoRj8=:r/aKZsxn5JVbDi3qN5TW5Y
 QrgAP2aQlBp2C68QY/P5GkQ+TI8y/nGEpk0XPos040b9vvb9xuoCV/Ct1tCb1mlLaaus6+fN2
 KT47t8OKA2i5JVDrhLIyynXKu4pXSXjS48RK1fKZqo90FsgOANiY2cu7Pdukqo4xtzd9qUK/k
 YdNwXerz4ZiCva5LczdBZ9d1AmLeQkvhBr6aKagNw1l2tN5tGLqG9a3GoUU99NMycT0vbI/qC
 Rw5rO3xReBIcUsTmj1ow/MRhtEMwMWyQ/myyQHgXIZy9rVQ5tPQzIoW/WKNLXtMHVZL+rWL0T
 MwrLe5BbJD2VqzVQIL4OZksBohaMlqEQWsrouy5tvJWSFqiifv4XJ5CbsTAWHnlofupVjVZoC
 MG0Utbl6cOGXAb9dbKniGCuPKSBxC6npHwtUwU8J8lUIKuw1A6ip9c8cgYxZoWjd5MgyAiuXl
 7a6ctfUKmmAU9b8KXoJkQizEuaSR8orsT+C1G1c1E3+fSYHXGTsJJ57FUQKj3EnbfOD49iMdA
 C9nZTOvaMUzXeNc64BDX34PuQ1B946rDVIdD9z114TjrhZikmlQnfLR9ElLQT63r2qhGTwa7K
 KxbU7nMr1owiqgzCEd9NF+0abOnK75UMMW6dUcrXkQ8lWPi8BSzqFhbNqst+Vsudp3WCSFxvn
 Nv6yEFWdjE6BSjWir/O2kmXrz6djAKizxyd/NY9gYPS/GbzrhBKbfM9yvX9aKeeKLLbgiDU3D
 kVt8j69S+q58VcHitEmiLGjzgz5eV85Qia+x+g==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079570802614121?=
X-GMAIL-MSGID: =?utf-8?q?1596079570802614121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Realign the arguments for update_recvframe_attrib() and
update_recvframe_phyinfo() so there is no trailing open parenthesis.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index d9a4567ca721..0e30e984dc1f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -29,9 +29,9 @@ static s32 initrecvbuf(struct recv_buf *precvbuf, struct adapter *padapter)
 	return _SUCCESS;
 }
 
-static void update_recvframe_attrib(
-	struct adapter *padapter, union recv_frame *precvframe, struct recv_stat *prxstat
-)
+static void update_recvframe_attrib(struct adapter *padapter,
+				    union recv_frame *precvframe,
+				    struct recv_stat *prxstat)
 {
 	struct rx_pkt_attrib *pattrib;
 	struct recv_stat report;
@@ -84,9 +84,8 @@ static void update_recvframe_attrib(
  *Before calling this function,
  *precvframe->u.hdr.rx_data should be ready!
  */
-static void update_recvframe_phyinfo(
-	union recv_frame *precvframe, struct phy_stat *pphy_status
-)
+static void update_recvframe_phyinfo(union recv_frame *precvframe,
+				     struct phy_stat *pphy_status)
 {
 	struct adapter *padapter = precvframe->u.hdr.adapter;
 	struct rx_pkt_attrib *pattrib = &precvframe->u.hdr.attrib;
-- 
2.16.3

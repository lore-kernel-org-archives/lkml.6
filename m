Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AH8x226TWgM+dAdbQfj1yByCrK3nqK/pa03KMIXy5wrJxzJvkTvlHdg+i9Pulu4eq9NBQ4FRneb3
ARC-Seal: i=1; a=rsa-sha256; t=1518395678; cv=none;
        d=google.com; s=arc-20160816;
        b=ryULSi2k8yqqskPBHvnqdtFgKcchUkIB/bT59jWN+ftiwvm+PxsNgUcGxcwHIxZR4P
         qIY+AU0I33QSfbeL9ZHEiIArMXFlGUalYTr4OzTQIVrfNdUb92wxDh2/qgJQSOLwilRa
         Y4rbANe6hlFB2wFJVddMynaLVwolDthoweRACxLE49L/BSOkh/h3rUovQufut8/gZF89
         33TyeIHjs1y4Vpf41BpfkwZ0YGvJYWAX5Pgc5c31UkSpzD9H7HkcYTTM4/RUROMXt3Ua
         +eAYtOn2cNZjav/G5fTGcAdh8jKdRFoTqSi/Kvwz+2eNL0TB2OSVXeN1FBg4rRMWFSJ4
         I7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/CxsDCDPqmR0F3so1vLHhlmj6ATaL0g9XM4OzSbERq0=;
        b=HH7zloaXlAgvI/e2Eg/E5OGGBF/CUqfIXXIXlyymWMOga5BUZwK2Rxqqbi6H1hpcbd
         vbMgayZAjextajQG0TVNtzUQLTugbrKrkggdL2dugcP+qLksontJXXSRwvcFsFhehvxi
         XQzX7M9a2MNLi2BQiTyW18fTdwHLf33/7Ml7Baat77Jb35ghdZTIj9JRFEqVAQEM0NIS
         I8Ww9/kulDcYDsfvRN0YOc50gOjnqnGkbKbSFsrh5qmw5jwpK37tvUmOP3aXpTNXlCPE
         D+ucOxANfDPHZKejZ4xPM52AGlyTBFGG9eir9D7BOlq9KvCX53U+IFgpVFlAVwQSnGha
         hI+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.38 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 07/12] hv_vmbus: Correct the stale comments regarding cpu affinity
Date: Sun, 11 Feb 2018 17:33:15 -0700
Message-Id: <20180212003320.6748-7-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212003320.6748-1-kys@exchange.microsoft.com>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfFBS4iFExjF+Ue2BP7ayEqngObyuDahQMBHeSI8RIlYOOQ2N7YSuR5UI1lb7Zqa8jHhm8zuUUdfrSVaLBMO2X8j5ssNCUS+y7V6unuCQOVBcg2D0W96Y
 BNuMi34GnE/zshj/D79Srfok51UxK5FXmC+5TnVJzdRH4/vN5jJncB/SFGgm193fRiy5SuAIQQxZpDMx65o6Su4iAfsKTGShAkkVZIkNdMZlq/AWQxnjCYx9
 g5RAvRpuy+Cn36f59pYjw5KYGNKJG8dnKlH7j73MnUC951OlTTwH8xpOycHj5Q9OqkEkmXq+yVMj1B1OLn4yeWL37Ko3gcG7ofP9KtiYDc0oY9nnUvlUlYgc
 Zc6hVzxA3Zt649f6QRgriK6uCMghGhmYOrcJgXcnX/QMl/g9ojzroz5Oet82QnpZXaVGda8ZeroOl1Oo3wuGyj9ylxg0OaLeCsz4e8uXlppT0TJQk4zl6NyF
 OEKTp9wDtXK0otRXTK99JQ+CSc4D3LAcjqyhkn3/un7G7McWM3t+rlaYE8jv3efW+/hK1xnn/5Luz4Z4jmyX8WDYNxDUvvTkmLFmqXfnEhlX8ncZ7ZHHXlqN
 oYyaEktNIVkXXJ6qowKLjSMl
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153266638604141?=
X-GMAIL-MSGID: =?utf-8?q?1592153266638604141?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

The comments doesn't match what the current code does, also have a
typo. This patch corrects them.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 6 ++----
 include/linux/hyperv.h    | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index c21020b69114..c6d9d19bc04e 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -596,10 +596,8 @@ static int next_numa_node_id;
 /*
  * Starting with Win8, we can statically distribute the incoming
  * channel interrupt load by binding a channel to VCPU.
- * We do this in a hierarchical fashion:
- * First distribute the primary channels across available NUMA nodes
- * and then distribute the subchannels amongst the CPUs in the NUMA
- * node assigned to the primary channel.
+ * We distribute the interrupt loads to one or more NUMA nodes based on
+ * the channel's affinity_policy.
  *
  * For pre-win8 hosts or non-performance critical channels we assign the
  * first CPU in the first NUMA node.
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 93bd6fcd6e62..2048f3c3b68a 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -844,7 +844,7 @@ struct vmbus_channel {
 
 	/*
 	 * NUMA distribution policy:
-	 * We support teo policies:
+	 * We support two policies:
 	 * 1) Balanced: Here all performance critical channels are
 	 *    distributed evenly amongst all the NUMA nodes.
 	 *    This policy will be the default policy.
-- 
2.15.1

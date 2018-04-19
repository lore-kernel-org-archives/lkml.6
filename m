Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbeDSBe3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:34:29 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33482 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeDSBeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:34:25 -0400
X-Google-Smtp-Source: AIpwx4+p5y+JThQuz/6QHoD94ajIp+8zaT2Y5BJr/z2lgK6KUl5Se8j9sl9oSnUvOfIKH73YgHCR5g==
From: Leo Yan <leo.yan@linaro.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH bpf-next 1/5] samples/bpf: Fix typo in comment
Date: Thu, 19 Apr 2018 09:34:02 +0800
Message-Id: <1524101646-6544-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
References: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo by replacing 'iif' with 'if'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 samples/bpf/bpf_load.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index bebe418..28e4678 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -393,7 +393,7 @@ static int load_elf_maps_section(struct bpf_map_data *maps, int maps_shndx,
 			continue;
 		if (sym[nr_maps].st_shndx != maps_shndx)
 			continue;
-		/* Only increment iif maps section */
+		/* Only increment if maps section */
 		nr_maps++;
 	}
 
-- 
1.9.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeEQO2p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:28:45 -0400
Received: from gateway20.websitewelcome.com ([192.185.69.18]:26320 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752374AbeEQO2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:28:43 -0400
X-Authority-Reason: nr=8
Date: Thu, 17 May 2018 09:04:30 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 0/2] bpf: sockmap, fix uninitialized variable and double-free
Message-ID: <cover.1526565461.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fJJWB-0006m8-CF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.172.56.86]:58190
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to fix an uninitialized variable issue and
a double-free issue in __sock_map_ctx_update_elem.

Both issues were reported by Coverity.

Thanks.

Gustavo A. R. Silva (2):
  bpf: sockmap, fix uninitialized variable
  bpf: sockmap, fix double-free

 kernel/bpf/sockmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.7.4

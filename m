Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeDIPCT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:02:19 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:50226 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeDIPCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:02:17 -0400
Date: Mon, 09 Apr 2018 11:02:14 -0400 (EDT)
Message-Id: <20180409.110214.2099089634160123216.davem@davemloft.net>
To: haibinzhang@tencent.com
Cc: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lidongchen@tencent.com,
        yunfangtai@tencent.com
Subject: Re: [PATCH RESEND v2] vhost-net: set packet weight of tx polling
 to 2 * vq size
From: David Miller <davem@davemloft.net>
In-Reply-To: <88D661ADF6AFBF42B2AB88D8E7682B0901FC4A32@EXMBX-SZMAIL011.tencent.com>
References: <88D661ADF6AFBF42B2AB88D8E7682B0901FC4A32@EXMBX-SZMAIL011.tencent.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w39F2N5O013387

From: haibinzhang(张海斌) <haibinzhang@tencent.com>
Date: Mon, 9 Apr 2018 07:22:17 +0000

> handle_tx will delay rx for tens or even hundreds of milliseconds when tx busy
> polling udp packets with small length(e.g. 1byte udp payload), because setting
> VHOST_NET_WEIGHT takes into account only sent-bytes but no single packet length.
> 
> Ping-Latencies shown below were tested between two Virtual Machines using
> netperf (UDP_STREAM, len=1), and then another machine pinged the client:
 ...
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Haibin Zhang <haibinzhang@tencent.com>
> Signed-off-by: Yunfang Tai <yunfangtai@tencent.com>
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

Applied, thank you.

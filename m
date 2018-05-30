Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbeE3VHY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:07:24 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43950 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbeE3VHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:07:18 -0400
X-Google-Smtp-Source: ADUXVKKUvV0FWNjpjD5z43+GRoGs5YNmFPMDw/o2USdJEMEYLQyDu40NDZhspf2SfvHInzpTCox8QQ==
Date: Wed, 30 May 2018 17:07:15 -0400
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Colin King <colin.king@canonical.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bpf: devmap: remove redundant assignment of dev =
 dev
Message-ID: <20180530210713.v4cf4wjniwyobfmm@ast-mbp.dhcp.thefacebook.com>
References: <20180530150916.16808-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530150916.16808-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 04:09:16PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The assignment dev = dev is redundant and should be removed.
> 
> Detected by CoverityScan, CID#1469486 ("Evaluation order violation")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, Thanks.

Please use [PATCH bpf-next] in the subject next time.
See Documentation/bpf/bpf_devel_QA.rst

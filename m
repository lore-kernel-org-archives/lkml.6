Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbeDTMKL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:10:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754607AbeDTMKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:10:09 -0400
Date: Fri, 20 Apr 2018 14:10:04 +0200
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Leo Yan <leo.yan@linaro.org>
Cc: brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/5] samples/bpf: Fix typo in comment
Message-ID: <20180420141004.259d7d6f@redhat.com>
In-Reply-To: <1524101646-6544-2-git-send-email-leo.yan@linaro.org>
References: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
        <1524101646-6544-2-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Apr 2018 09:34:02 +0800 Leo Yan <leo.yan@linaro.org> wrote:

> Fix typo by replacing 'iif' with 'if'.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  samples/bpf/bpf_load.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
> index bebe418..28e4678 100644
> --- a/samples/bpf/bpf_load.c
> +++ b/samples/bpf/bpf_load.c
> @@ -393,7 +393,7 @@ static int load_elf_maps_section(struct bpf_map_data *maps, int maps_shndx,
>  			continue;
>  		if (sym[nr_maps].st_shndx != maps_shndx)
>  			continue;
> -		/* Only increment iif maps section */
> +		/* Only increment if maps section */
>  		nr_maps++;
>  	}

This was actually not a typo from my side.

With 'iif' I mean 'if and only if' ... but it doesn't matter much.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

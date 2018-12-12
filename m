Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2379AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63072084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63072084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeLLKYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:24:06 -0500
Received: from www62.your-server.de ([213.133.104.62]:39944 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeLLKYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:24:06 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gX1gR-0000Gy-EA; Wed, 12 Dec 2018 11:24:03 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gX1gR-000HU3-6o; Wed, 12 Dec 2018 11:24:03 +0100
Subject: Re: [PATCH 7/7] selftest/bpf: fix E501 line too long
To:     Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc:     jakub.kicinski@netronome.com, ast@kernel.org, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
 <20181211115607.13774-8-alice.ferrazzi@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <62f6127d-edf6-2d41-cd7d-1c1c20607b38@iogearbox.net>
Date:   Wed, 12 Dec 2018 11:24:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181211115607.13774-8-alice.ferrazzi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25199/Wed Dec 12 03:21:46 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Jakub ]

On 12/11/2018 12:56 PM, Alice Ferrazzi wrote:
> fix PEP8 style issues
> 
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_offload.py | 35 +++++++++++++--------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
> index b06cc0eea0eb..3f78da0f87d5 100755
> --- a/tools/testing/selftests/bpf/test_offload.py
> +++ b/tools/testing/selftests/bpf/test_offload.py
> @@ -208,7 +208,8 @@ def bpftool_prog_list_wait(expected=0, n_retry=20):
>          if nprogs == expected:
>              return
>          time.sleep(0.05)
> -    raise Exception("Time out waiting for program counts to stabilize want %d, have %d" % (expected, nprogs))
> +    raise Exception("Time out waiting for program counts \
> +to stabilize want %d, have %d" % (expected, nprogs))
>  
>  
>  def bpftool_map_list_wait(expected=0, n_retry=20):
> @@ -217,7 +218,8 @@ def bpftool_map_list_wait(expected=0, n_retry=20):
>          if nmaps == expected:
>              return
>          time.sleep(0.05)
> -    raise Exception("Time out waiting for map counts to stabilize want %d, have %d" % (expected, nmaps))
> +    raise Exception("Time out waiting for map counts to \
> +stabilize want %d, have %d" % (expected, nmaps))
>  
>  
>  def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
> @@ -413,7 +415,8 @@ class NetdevSim:
>              if nbound == bound and nprogs == total:
>                  return
>              time.sleep(0.05)
> -        raise Exception("Time out waiting for program counts to stabilize want %d/%d, have %d bound, %d loaded" % (
> +        raise Exception("Time out waiting for program counts to \
> +stabilize want %d/%d, have %d bound, %d loaded" % (
>              bound, total, nbound, nprogs))

I'll leave the test_offload.py ones up to Jakub, but to me it seems this particular
change here would actually make the code look worse and harder to grep for error
messages, so my preference would be to at least leave the error messages as-is. Also
seems it's not a 'must' in pep8 [0].

  [0] https://www.python.org/dev/peps/pep-0008/#maximum-line-length

Thanks,
Daniel

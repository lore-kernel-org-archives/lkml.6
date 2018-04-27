Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759179AbeD0UVZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:21:25 -0400
Received: from www62.your-server.de ([213.133.104.62]:60965 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758944AbeD0UVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:21:24 -0400
Subject: Re: [PATCH 2/2] bpf: btf: remove a couple conditions
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Martin KaFai Lau <kafai@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180427140459.GB19583@mwanda>
 <20180427172023.6japncdd3nbqauzn@kafai-mbp>
 <20180427175544.vydqf4iufopcyv6d@kafai-mbp>
 <20180427193959.3nebosalgl3ch4mv@mwanda>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <21126ae9-5178-5d09-679c-6bca57ad48e8@iogearbox.net>
Date: Fri, 27 Apr 2018 22:21:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180427193959.3nebosalgl3ch4mv@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 09:39 PM, Dan Carpenter wrote:
> On Fri, Apr 27, 2018 at 10:55:46AM -0700, Martin KaFai Lau wrote:
>> On Fri, Apr 27, 2018 at 10:20:25AM -0700, Martin KaFai Lau wrote:
>>> On Fri, Apr 27, 2018 at 05:04:59PM +0300, Dan Carpenter wrote:
>>>> We know "err" is zero so we can remove these and pull the code in one
>>>> indent level.
>>>>
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Thanks for the simplification!
>>>
>>> Acked-by: Martin KaFai Lau <kafai@fb.com>
>> btw, it should be for bpf-next.  Please tag the subject with bpf-next when
>> you respin. Thanks!

Dan, thanks a lot for your fixes! Please respin with addressing Martin's
feedback when you get a chance.

Thanks,
Daniel

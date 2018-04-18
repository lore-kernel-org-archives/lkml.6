Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeDRUJr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 16:09:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58468 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeDRUJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 16:09:46 -0400
Subject: Re: [PATCH v3] docs: kernel-parameters.txt: Fix whitespace
To: Thymo van Beers <thymovanbeers@gmail.com>, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180418185136.GA27678@thinkpad>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d092a75f-2456-c077-28f2-cb83a73ca5f7@infradead.org>
Date: Wed, 18 Apr 2018 13:09:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418185136.GA27678@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/18 11:51, Thymo van Beers wrote:
> Some lines used spaces instead of tabs at line start.
> This can cause mangled lines in editors due to inconsistency.
> 
> Replace spaces for tabs where appropriate.
> 
> Signed-off-by: Thymo van Beers <thymovanbeers@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> Changes in v3:
>   - Change indentation in intel_pstate to reduce overrunning 80-column
>     mark
>   - Indent "nohrst, nosrst, norst:" like "rstonce"

intel_pstate, isolcpus, maxcpus, onenand.bdry, reboot (and a few others)
do still go beyond 80 columns.  Those could be fixed later (or not).

Thanks.


> Changes in v2:
>   - Rebase against docs-next
>   - Fix indentation modifications
> 
>  Documentation/admin-guide/kernel-parameters.txt | 136 ++++++++++++------------
>  1 file changed, 68 insertions(+), 68 deletions(-)


-- 
~Randy

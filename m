Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeCTURz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 16:17:55 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:43846 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeCTURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 16:17:51 -0400
X-IronPort-AV: E=Sophos;i="5.48,337,1517875200";
   d="scan'208";a="70288596"
Subject: Re: [PATCH] fix one dead link in ia64/xen.txt
To: Dongliang Mu <mudongliangabcd@gmail.com>, <corbet@lwn.net>,
        <yamada.masahiro@socionext.com>, <slyfox@gentoo.org>,
        <tony.luck@intel.com>, <bjorn.forsman@gmail.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180320195658.17498-1-mudongliangabcd@gmail.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <91363263-1ab8-5513-23a3-bbcea802d788@citrix.com>
Date: Tue, 20 Mar 2018 20:17:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320195658.17498-1-mudongliangabcd@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/18 19:56, Dongliang Mu wrote:
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  Documentation/ia64/xen.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ia64/xen.txt b/Documentation/ia64/xen.txt
> index a12c74ce2773..464d4c29b8b5 100644
> --- a/Documentation/ia64/xen.txt
> +++ b/Documentation/ia64/xen.txt
> @@ -26,8 +26,8 @@ Getting and Building Xen and Dom0
>      DomainU OS  : RHEL5
>  
>   1. Download source
> -    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable.hg
> -    # cd xen-unstable.hg
> +    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable
> +    # cd xen-unstable
>      # hg clone http://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg
>  
>   2. # make world

The last commit in that repository is almost 9 years old, and IA64
support was dropped from Xen mainline6 years ago.

http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=570c311ca2c7a1131570cdfc77e977bc7a9bf4c0

There are a number of other dead links in this doc, and those which
aren't dead refer to Linux 2.6.x.  I'd just remove the entire file,
rather than pretend that any of this still might work.  (If by some
miracle it does still function, its 10 years behind on security fixes...)

~Andrew

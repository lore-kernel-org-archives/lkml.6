Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933059AbeD0X2u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 19:28:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932444AbeD0X2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 19:28:49 -0400
Date: Sat, 28 Apr 2018 07:28:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yinghai@kernel.org, vgoyal@redhat.com
Subject: Re: [PATCH 1/2] kdump/x86: crashkernel=X try to reserve below 896M
 first then below 4G and MAXMEM
Message-ID: <20180427232843.GA30581@MiWiFi-R3L-srv>
References: <20180427090045.532014306@redhat.com>
 <20180427091410.GA25338@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427091410.GA25338@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/18 at 05:14pm, Dave Young wrote:
> Hi,
>  
> This is a resend of below patches:
> http://lists.infradead.org/pipermail/kexec/2017-October/019569.html
>  
> I dropped the original patch 1 since Baoquan is not happy with it.
> For patch 2 (the 1st patch in this series), there is some improvement
> comment from Baoquan to create some generic memblock iteration function.
> But nobody has time to work on it for the time being.  According to
> offline discussion with him.  That can be done in the future if someone
> is interested.  We can go with the current kdump only fixes.
>  
> Other than above,  the patches are just same.

Thanks to work on this. Looks good to me.

ACK

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

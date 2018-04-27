Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeD0JOV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:14:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932370AbeD0JOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:14:20 -0400
Date: Fri, 27 Apr 2018 17:14:10 +0800
From: Dave Young <dyoung@redhat.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, yinghai@kernel.org, akpm@linux-foundation.org,
        vgoyal@redhat.com
Subject: Re: [PATCH 1/2] kdump/x86: crashkernel=X try to reserve below 896M
 first then below 4G and MAXMEM
Message-ID: <20180427091410.GA25338@dhcp-128-65.nay.redhat.com>
References: <20180427090045.532014306@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427090045.532014306@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
This is a resend of below patches:
http://lists.infradead.org/pipermail/kexec/2017-October/019569.html
 
I dropped the original patch 1 since Baoquan is not happy with it.
For patch 2 (the 1st patch in this series), there is some improvement
comment from Baoquan to create some generic memblock iteration function.
But nobody has time to work on it for the time being.  According to
offline discussion with him.  That can be done in the future if someone
is interested.  We can go with the current kdump only fixes.
 
Other than above,  the patches are just same.
 
Thanks
Dave

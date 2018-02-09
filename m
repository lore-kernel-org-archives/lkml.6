Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeBILlU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:41:20 -0500
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:56360 "EHLO
        5.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeBILlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:41:19 -0500
Date: Fri, 9 Feb 2018 12:33:42 +0100
From: Greg Kurz <groug@kaod.org>
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>,
        <v9fs-developer@lists.sourceforge.net>, <qemu-devel@nongnu.org>,
        <aneesh.kumar@linux.vnet.ibm.com>, Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Veaceslav Falico <veaceslav.falico@huawei.com>
Subject: Re: [V9fs-developer] [RFC] we should solve create-unlink-getattr
 idiom
Message-ID: <20180209123342.11b17062@bahia.lan>
In-Reply-To: <5A7D4976.6060407@huawei.com>
References: <5A7D4976.6060407@huawei.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9747478444629268773
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrvddtgdeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2018 15:10:46 +0800
jiangyiwen <jiangyiwen@huawei.com> wrote:

> Hi Eric and Greg,
> 
> I encountered the similar problem with create-unlink-getattr idiom.
> I use the testcase that create-unlink-setattr idiom, and I see the
> bug is reported at https://bugs.launchpad.net/qemu/+bug/1336794.
> Then I also see you already fix the issue and push the patch to upstream.
> https://github.com/ericvh/linux/commit/eaf70223eac094291169f5a6de580351890162a2
> http://patchwork.ozlabs.org/patch/626194/
> 
> Unfortunately, the two patches are not merged into master, I don't know
> the reason, so I suggest if the patche can be merged into master, and
> it will solve the create-unlink-getattr idiom.
> 

I had tried to go a bit further and address the general issue of f*() syscalls
versus unlinked files:

QEMU:
http://lists.gnu.org/archive/html/qemu-devel/2016-06/msg07586.html

Linux 9p driver:
https://sourceforge.net/p/v9fs/mailman/message/35175775/

I remember that some issues were then reported during review of the
linux patches, and I never got bandwidth to investigate further...

But if you'd like to resurrect these threads, please do. :)

> Thanks,
> Yiwen
> 

Cheers,

--
Greg

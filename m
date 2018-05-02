Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEBIUG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:20:06 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:46944 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBIUD (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Wed, 2 May 2018 04:20:03 -0400
Message-Id: <5AE974AD02000078001C00A8@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 02 May 2018 02:19:57 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 4/4] xen/PVH: Remove reserved entry in
 PVH GDT
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-5-boris.ostrovsky@oracle.com>
In-Reply-To: <20180430162339.17143-5-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 30.04.18 at 18:23, <boris.ostrovsky@oracle.com> wrote:
> And without it we can't use _BOOT_XX macros any longer so define new ones.

Ah, here we go. Perhaps this should be moved earlier in the series?
Assuming you really want to go this route in the first place, taking
Roger's comment into consideration.

Jan

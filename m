Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeEVKNi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:13:38 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:34783 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbeEVKNg (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Tue, 22 May 2018 06:13:36 -0400
Message-Id: <5B03ED4A02000078001C48FD@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Tue, 22 May 2018 04:13:30 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] xen/PVH: Set up GS segment for stack canary
References: <20180522035445.16911-1-boris.ostrovsky@oracle.com>
 <20180522035445.16911-2-boris.ostrovsky@oracle.com>
In-Reply-To: <20180522035445.16911-2-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 22.05.18 at 05:54, <boris.ostrovsky@oracle.com> wrote:
> We are making calls to C code (e.g. xen_prepare_pvh()) which may use
> stack canary (stored in GS segment).
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

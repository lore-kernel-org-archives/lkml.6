Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeDIMRZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:17:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbeDIMRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:17:24 -0400
Date: Mon, 9 Apr 2018 14:17:22 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "himanshu.madhani@cavium.com" <himanshu.madhani@cavium.com>
Subject: Re: [PATCH] qla2xxx: correctly shift host byte
Message-ID: <20180409121722.zijiq63mo56ovewg@linux-x5ow.site>
References: <20180406075222.7358-1-jthumshirn@suse.de>
 <0753246e70d16062b87930b2b75eec31a4bb88eb.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0753246e70d16062b87930b2b75eec31a4bb88eb.camel@wdc.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 03:01:20PM +0000, Bart Van Assche wrote:
> Please mention in the description of this patch that this patch does not
> change any functionality because DID_OK == 0. Anyway:
> 
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>

I'll do. Thanks for the review.
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeBZNCh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:02:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:40761 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753177AbeBZNCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:02:32 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Matias =?utf-8?Q?Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: hch@lst.de, keith.busch@intel.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/1] nvme: implement log page low/high offset and dwords
References: <20180226125540.9513-1-mb@lightnvm.io>
        <20180226125540.9513-2-mb@lightnvm.io>
Date: Mon, 26 Feb 2018 14:02:30 +0100
In-Reply-To: <20180226125540.9513-2-mb@lightnvm.io> ("Matias =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B8rling=22's?=
        message of "Mon, 26 Feb 2018 13:55:40 +0100")
Message-ID: <mqdy3jfc3a1.fsf@linux-x5ow.site>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

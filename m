Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeDSJQK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:16:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750989AbeDSJQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:16:09 -0400
Date: Thu, 19 Apr 2018 11:16:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-ccw: process ssch with interrupts disabled
Message-ID: <20180419111605.31354176.cohuck@redhat.com>
In-Reply-To: <20180418082931.GO5428@bjsdjshi@linux.vnet.ibm.com>
References: <20180413140509.9042-1-cohuck@redhat.com>
        <20180418082931.GO5428@bjsdjshi@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 16:29:31 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2018-04-13 16:05:09 +0200]:
> 
> Nitpick for the title:
> vfio-ccw: process ssch with interrupts disabled
> 
> Should be "vfio: ccw:"?

Yes, that seems to be the more common title.

I've added a cc:stable as well (as the current trend seems to be to
rather add more to stable than less) and pushed out. Unless there are
complaints, I'll send a pull req tomorrow.

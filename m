Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932542AbeCOPZz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:25:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeCOPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:25:55 -0400
Date: Thu, 15 Mar 2018 16:25:51 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 05/10] iommu/amd: remove the special case from
 get_irq_table()
Message-ID: <20180315152551.vsut2dt7b2m7guyu@linutronix.de>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
 <20180223222736.18542-6-bigeasy@linutronix.de>
 <20180315125342.q74wurk6bdbhl6hy@8bytes.org>
 <20180315130153.3ba2loj5oplogdew@linutronix.de>
 <20180315130723.dunmpmbkswwvq54g@8bytes.org>
 <20180315141541.6g3xc6yi4siafuwr@linutronix.de>
 <20180315151917.pgheszruqnnjbqb4@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315151917.pgheszruqnnjbqb4@8bytes.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-15 16:19:17 [+0100], Joerg Roedel wrote:
> Okay, if the irq-layer does the needed locking, then we don't need
> another lock here. There is the modify_irte_ga() path for the
> virtualized irq routing into KVM guests, but there should be no KVM
> guests running when setup the ioapic routing entries.

okay then. Let me rebase the queue on top whatever you have now and then
if the box still boots I will post them again.

> 	Joerg

Sebastian

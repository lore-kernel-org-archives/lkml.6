Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeCTKPd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:15:33 -0400
Received: from ozlabs.org ([103.22.144.67]:55489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751929AbeCTKPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:15:31 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a0828cf57acce9bf941539e1f633e9a91f9df57d
In-Reply-To: <03b68902-629e-65ab-a5e8-d90a3613f596@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alistair Popple <alistair@popple.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>, Rob Herring <robh@kernel.org>,
        Russell Currey <ruscur@russell.cc>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [3/3] powernv/pci: Improve a size determination in pnv_pci_init_ioda_phb()
Message-Id: <40582V075Xz9sZC@ozlabs.org>
Date: Tue, 20 Mar 2018 21:15:29 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2017-10-17 at 15:40:17 UTC, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 17 Oct 2017 17:18:10 +0200
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a0828cf57acce9bf941539e1f633e9

cheers

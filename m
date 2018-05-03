Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeECRL4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:11:56 -0400
Received: from namei.org ([65.99.196.166]:59270 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeECRLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:11:54 -0400
Date: Fri, 4 May 2018 03:11:31 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
cc: David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Keyrings <keyrings@vger.kernel.org>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Linux Security <linux-security-module@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 0/4] Certificate insertion support for x86 bzImages
In-Reply-To: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1805040311050.12843@namei.org>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018, Mehmet Kayaalp wrote:

> These patches add support for modifying the reserved space for extra
> certificates in a compressed bzImage in x86. This allows separating the
> system keyring certificate from the kernel build process. After the kernel
> image is distributed, the insert-sys-cert script can be used to insert the
> certificate for x86.

Can you provide more explanation of how this is useful and who would use 
it?

-- 
James Morris
<jmorris@namei.org>

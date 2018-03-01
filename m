Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935664AbeCABdQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 20:33:16 -0500
Received: from ozlabs.org ([103.22.144.67]:37763 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932134AbeCABdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 20:33:15 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'
In-Reply-To: <20180228224406.7049-1-robh@kernel.org>
References: <20180228224406.7049-1-robh@kernel.org>
Date: Thu, 01 Mar 2018 12:33:08 +1100
Message-ID: <87606ga8bv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> 'linux,stdout-path' has been deprecated for some time in favor of
> 'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
> Search and replace all the of occurrences with 'stdout-path'.

This patch looks OK.

But please remember that not all device trees are generated with dtc, we
still have machines in the wild that have firmware which use
"linux,stdout-path" and may never be updated.

cheers

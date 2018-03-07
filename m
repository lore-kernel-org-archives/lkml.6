Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeCGHL0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 02:11:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750989AbeCGHLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 02:11:23 -0500
Date: Wed, 7 Mar 2018 15:11:14 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, eric.auger@redhat.com, aik@ozlabs.ru
Subject: Re: [PATCH 1/3] vfio/pci: Pull BAR mapping setup from read-write path
Message-ID: <20180307071114.GM17720@xz-mi>
References: <20180228195504.25283.45666.stgit@gimli.home>
 <20180228201446.25283.82272.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228201446.25283.82272.stgit@gimli.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 01:14:46PM -0700, Alex Williamson wrote:
> This creates a common helper that we'll use for ioeventfd setup.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

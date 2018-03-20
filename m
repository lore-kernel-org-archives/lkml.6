Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbeCTPPQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:15:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeCTPPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:15:14 -0400
Date: Tue, 20 Mar 2018 08:15:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: KAMEI Hitoshi <hitoshi.kamei.xm@hitachi.com>
Cc: idryomov@gmail.com, sage@redhat.com, elder@kernel.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rbd: add 'thick' sysfs rbd device attribute
Message-ID: <20180320151510.GA13059@infradead.org>
References: <5AAFA69E.2050007@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AAFA69E.2050007@hitachi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The normal storage term would be fully provisioned, not 'thick'

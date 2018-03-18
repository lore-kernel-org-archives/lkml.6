Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeCRM5c (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:57:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:47007 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753955AbeCRMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:05 -0400
X-Google-Smtp-Source: AG47ELuqMDPwHK5z40mhyvlVSgRx1ej1LWPKuIkoPDgEM7XX4XSi8Zk68iumfvm7HAYwwZyS82l6rw==
Date: Sun, 18 Mar 2018 07:52:01 -0500
From: Rob Herring <robh@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] of: unittest: fix an error code in
 of_unittest_apply_overlay()
Message-ID: <20180318125201.aezip6bgycmvgbqa@rob-hp-laptop>
References: <20180314200828.GA10588@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314200828.GA10588@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 11:08:28PM +0300, Dan Carpenter wrote:
> We accidentally return zero on failure instead of a negative error code.
> 
> Fixes: 39a751a4cb7e ("of: change overlay apply input data from unflattened to FDT")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.

Rob

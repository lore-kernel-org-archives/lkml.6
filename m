Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeCPUEK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:04:10 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:44706 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbeCPUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:04:07 -0400
X-Google-Smtp-Source: AG47ELtITZsVdv0mUMKVqz54IoV6qQLOmTBw6Cu++43KosAGWsuZAe5VXFOv1peDwPSGeQub8exScQ==
Date: Fri, 16 Mar 2018 22:40:32 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kieran.bingham@ideasonboard.com
Cc: rasmus.villemoes@prevas.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] kernel.h: provide array iterator
Message-ID: <20180316194032.GA7589@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Proper form for iteration over an array is below:

	int a[] = {1, 2, 3, 5};
	for (int x: a) {
		...
	}

Your macro forces an iterator to be pointer which is uh-oh.

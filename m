Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754513AbeE1R2I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 13:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754369AbeE1R2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 13:28:03 -0400
Date: Mon, 28 May 2018 14:28:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Use header file util/debug.h
Message-ID: <20180528172800.GE25467@kernel.org>
References: <20180528134817.36643-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528134817.36643-1-tmricht@linux.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 28, 2018 at 03:48:17PM +0200, Thomas Richter escreveu:
> Use the header file util/debug.h instead of
> declaration of verbose variable.

Thanks, applied.

- Arnaldo

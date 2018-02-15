Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033574AbeBOPBG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:01:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033445AbeBOPBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:01:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F34217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 12:01:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jaecheol Shin <jcgod413@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>
Subject: Re: [PATCH] perf annotate: Add missing arguments in Man page
Message-ID: <20180215150102.GG30974@kernel.org>
References: <20180207095205.62715-1-jcgod413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207095205.62715-1-jcgod413@gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 07, 2018 at 06:52:05PM +0900, Jaecheol Shin escreveu:
> From: jcgod413 <jcgod413@gmail.com>
> 
> Some options must require an argument. But input, stdio-color, cpu have no them.
> So I added it.

Thanks, applied.

- Arnaldo

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeA3Rwv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:52:51 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:42983 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbeA3Rwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:52:49 -0500
X-Google-Smtp-Source: AH8x2254n5fRYQW/CQ1DFmMkNUWJHwl+D2UW+MM2W85B9BUbR4n55B2iadzSS3T99rBQY1GohwIbUA==
Date: Tue, 30 Jan 2018 09:52:45 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Paul Menzel <pmenzel+linux-input@molgen.mpg.de>
Cc: linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+linux-input@molgen.mpg.de
Subject: Re: i8042 AUX port [serio1] suspend takes a second on Dell XPS 13
 9360 and TUXEDO Book 1406
Message-ID: <20180130175017.72inurhk5l7tcvae@dtor-ws>
References: <5a74e1a7-2083-c6b2-f51a-f44908ac8bc4@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a74e1a7-2083-c6b2-f51a-f44908ac8bc4@molgen.mpg.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Jan 30, 2018 at 06:36:34PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> I do not know, when it started, but with Linux 4.14-rc8 and 4.15,
> benchmarking suspend and resume time with `sleepgraph.py` [1][2], there is a
> regression, that i8042 AUX port [serio1] suspend takes a second on Dell XPS
> 13 9360 and TUXEDO Book 1406.

It would be really helpful to know when the regression started.

Thanks.

-- 
Dmitry

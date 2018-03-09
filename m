Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbeCICf5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:35:57 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:46964 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeCICfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:35:55 -0500
X-Google-Smtp-Source: AG47ELubL/HJexCrgsCWJQvspkRzpcQhiKGJ0j72xuwCp4vqDvqcHPElmKkGYNxtvNiVCk+v2nSPuA==
Subject: Re: [PATCH] Documentation/cdrom: fix German sharp s in LaTex
To: Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <edd92692-d2c8-70cc-1870-f867ff91ee38@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <04ccc4d5-de09-56b6-730e-30ec64240a69@kernel.dk>
Date: Thu, 8 Mar 2018 19:35:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <edd92692-d2c8-70cc-1870-f867ff91ee38@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/18 5:31 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Apparently the LaTex abbreviation for the German "sharp s" (ß)
> (Unicode U+00DF) has changed from {\sz} to {\ss}.  With {\sz},
> I get this error at line 1016 (line number after another patch):
> 
> ! Undefined control sequence.
> l.1016 ...nel~2.0.  Further thanks to Heiko Ei{\sz
>                                                   }feldt,

Applied, thanks.

-- 
Jens Axboe

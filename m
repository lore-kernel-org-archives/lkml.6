Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935936AbeCHROz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:14:55 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:39551 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbeCHROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:14:53 -0500
X-Google-Smtp-Source: AG47ELtHrY9zSPTMobjWR8qoBmuywlCfhHuljwCG1CvY4hbuCYJ0bmHqWqJGppRlRMY9IiwduLQ5Kw==
Date: Thu, 08 Mar 2018 09:14:52 -0800 (PST)
X-Google-Original-Date: Thu, 08 Mar 2018 09:12:30 PST (-0800)
Subject: Re: RFC: remove the "tile" architecture from glibc
In-Reply-To: <CAK8P3a2VuYxzy6RmL_w_5f2qHepVRhfVR5P4x9nCUYav1s5n7g@mail.gmail.com>
CC: helmut@subdivi.de, Arnd Bergmann <arnd@arndb.de>,
        glaubitz@physik.fu-berlin.de, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, metcalf@alum.mit.edu, hgb@ifi.uio.no,
        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-160eeec9-bd53-4c63-901a-630c66a78534@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Mar 2018 07:55:33 PST (-0800), Arnd Bergmann wrote:
> - riscv32 is not yet supported by Linux or glibc, but that seems
>   very likely to come in the future, maybe one or two years from
>   now.

I'm hoping it'll be a lot less than a year away :).

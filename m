Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeBFMcJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:32:09 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:50517 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFMcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:32:00 -0500
X-Google-Smtp-Source: AH8x225i/cx8K7jy2U695R7XIiZ9OyGnOCEu0yC4z3xRscQIMX/d4zZpQZKAkHIhUHQcB4TgMVRxMQ==
Subject: Re: [PATCH 0/2] trace-cmd: Improves python plugin support
To: rostedt@goodmis.org
Cc: johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com
References: <20180204032014.6962-1-sztsian@gmail.com>
From: Zamir SUN <sztsian@gmail.com>
Message-ID: <18dbee92-3f25-781f-9beb-7bef9d6c12d9@gmail.com>
Date: Tue, 6 Feb 2018 20:31:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180204032014.6962-1-sztsian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Do you have any thoughts for this?

Thanks.

On 02/04/2018 11:20 AM, sztsian@gmail.com wrote:
> From: Zamir SUN (Red Hat) <sztsian@gmail.com>
> 
> This is a set of patch to improve trace-cmd python plugin support.
> 
> Patch 1 fixes the detection for swig. With this patch, python-plugin can
> be built successfully.
> 
> Patch 2 improves the detection for python ldflags. With this patch,
> ldflags can be detected with python3 in the future.
> 
> Zamir SUN (2):
>   trace-cmd: Fix the detection for swig
>   trace-cmd: Change the way of getting python ldflags.
> 
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

-- 
Zamir SUN
Fedora user
GPG : 1D86 6D4A 49CE 4BBD 72CF FCF5 D856 6E11 F2A0 525E

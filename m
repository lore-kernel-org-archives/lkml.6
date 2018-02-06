Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeBFJuN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:50:13 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:50152 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752403AbeBFJuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:50:04 -0500
Subject: Re: [RFCv2 00/17] Request API, take three
To: Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180131102427.207721-1-acourbot@chromium.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <b7d08a9b-40bb-e501-bd2f-05c8ef8f7339@xs4all.nl>
Date: Tue, 6 Feb 2018 10:49:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180131102427.207721-1-acourbot@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDUw4UZ+69Otnz0eI+uQsJ69ru/EVTN2kREp2Mv63A2XWOKXZ+v1KHMakYcqaTXbkoyxCJXFcikrHkLXMkICK3JgoI5T2wXfK1D9kgN9p/KH1ItrzqT1
 p+tb9J+84eX3VctGVi3PfmdLXvRxRRk28HfiMaliEsOg1s1zzVjj7ACXkMI5SQJw0W5kMnJnq6UHvDsJH/1d2PqjN3JfcqcBFIXYE9Voma8sEdSjK5EYIrRB
 mD2C56NelyaAaq8ropEs0qP3NkTPNfE4HyADwRIIqeTcynQKxYPcrYm5YYzu76UJzNaHDkq6gKIy7Wp3xtIAZ4uGQktx4j0TYvFM9aW7zlwlA/7bGHjkA0XC
 sAvadDe1QwbbQXyJILuzlkZ43XcglMlAzBoeI39vQhJIgHg0mie3C2kwc1Rf9VdbhtNLt4KroZGisTKnNXywCMdI1+xzM/an5RP2CVGyOiJh1ZGB798JtjvV
 Xc0QcrKijWuLDe+4PAsZL4qFWSPRdiIm2gg0P3OU4NLxc76KtHuaE9aI0B0BQuW7P3LK5Gm4SW7qX/Ik0gdadEN/j94dc58NCJDhQEU0B2BOdw1yycRjLI7k
 /YI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 01/31/18 11:24, Alexandre Courbot wrote:
> This is a quickly-put together revision that includes and uses Hans' work to
> use v4l2_ctrl_handler as the request state holder for V4L2 devices. Although
> minor fixes have also been applied, there are still a few comments from the
> previous revision that are left unaddressed. I wanted to give Hans something
> to play with before he forgets what he had in mind for controls. ;)
> 
> Changelog since v1:
> * Integrate Hans control framework patches so S_EXT_CTRLS and G_EXT_CTRLS now
>   work with requests
> * Only allow one buffer at a time for a given request in the buffer queue
> * Applied comments related to documentation and document control ioctls
> * Minor small fixes
> 
> I have also updated the very basic program that demonstrates the use of the
> request API on vim2m:
> 
> https://gist.github.com/Gnurou/dbc3776ed97ea7d4ce6041ea15eb0438
> 
> It does not do much, but gives a practical idea of how requests should be used.

Can you rebase and repost? It doesn't apply anymore to the latest media_tree master.
Among others v4l2-core/videobuf2-* has been moved to common/videobuf2/videobuf2-*.

But there are also conflicts in v4l2-compat-ioctl32.c.

Thanks!

	Hans

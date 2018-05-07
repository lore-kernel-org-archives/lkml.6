Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeEGJZy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:25:54 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:40523 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751830AbeEGJZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:25:51 -0400
Subject: Re: [PATCH] media: v4l2-dev.h: document VFL_TYPE_MAX
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
References: <0293dccdddd73007013831d7e65834a05827e3f8.1525684917.git.mchehab+samsung@kernel.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <59ad2053-efb8-7774-a2de-c338921ecdc0@xs4all.nl>
Date: Mon, 7 May 2018 11:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0293dccdddd73007013831d7e65834a05827e3f8.1525684917.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCqxbmMiz2rbbGOb++0/ENovJjcuKyF92poX91YISMyl7GgoHsVB8XSYdzB2UAVKV/YzTfTKGcC+kEGXMh8bo8vTXoQAvzHaDWRIMkQ5uSUZutSJBgj+
 LDFImWNRpoJ5HShFvtxei+j+v+i0KMOn6cDCUm3wAEPVvmm7DYlrpUROnc/C4FbFUrx5EVlVaNW2OaomaTZHvqmxPgLy+ClZsU77bFNh3qago9i5SURwwB0b
 vUilt5S0LcYPCyZ6gFZ9sWW7HcjELiHS1yXTqGc6Dl/kCjUcOYBvynTs2uDsXEPtPDQxVJrCrB5n+Gb5HZAvyd01B3E1jL4xpEGyZII7ak84Xs4WHAEiVyJV
 WI7ao+ll++iyTAXiAxXO7fKGQeFsrjBwMR4lpg4AG/IvkzQUWCk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/18 11:22, Mauro Carvalho Chehab wrote:
> Cleanup this Sphinx warning:
>    read./include/media/v4l2-dev.h:42: warning: Enum value 'VFL_TYPE_MAX' not described in enum 'vfl_devnode_type'

Posted patch for this already, part of an upcoming pull request from me:

https://patchwork.linuxtv.org/patch/49189/

Regards,

	Hans

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  include/media/v4l2-dev.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
> index f60cf9cf3b9c..9e73d7e2cee0 100644
> --- a/include/media/v4l2-dev.h
> +++ b/include/media/v4l2-dev.h
> @@ -30,6 +30,8 @@
>   * @VFL_TYPE_SUBDEV:	for V4L2 subdevices
>   * @VFL_TYPE_SDR:	for Software Defined Radio tuners
>   * @VFL_TYPE_TOUCH:	for touch sensors
> + *
> + * @VFL_TYPE_MAX:	number of elements of &enum vfl_devnode_type
>   */
>  enum vfl_devnode_type {
>  	VFL_TYPE_GRABBER	= 0,
> 

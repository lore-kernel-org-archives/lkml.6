Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeC0K2O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:28:14 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37086 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeC0K2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:28:12 -0400
X-Google-Smtp-Source: AG47ELurkC/RX7N+Q7p2qo2U1D/+L949RHhSoXYvJngP8KrBlOdZcEgX2WJwcPCxJqgKiBeaIi1D8A==
Subject: Re: [PATCH script] hwmon: Use octal not symbolic permissions
To: Joe Perches <joe@perches.com>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        patches@opensource.cirrus.com
References: <1522096136.12357.21.camel@perches.com>
 <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
 <1522136107.12357.58.camel@perches.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5ec8703b-2979-7a1d-fbc3-bd528d7a5e29@roeck-us.net>
Date: Tue, 27 Mar 2018 03:28:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522136107.12357.58.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 12:35 AM, Joe Perches wrote:
> On Mon, 2018-03-26 at 23:33 -0700, Guenter Roeck wrote:
>> Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",
> 
> fyi: It's marked Maintained in MAINTAINERS
> 

I did not say that it was not maintained, and I am aware of the information
in the MAINTAINERS file, thanks.

Guenter

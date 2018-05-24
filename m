Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935717AbeEXIOi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:14:38 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:38746 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935502AbeEXIOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:14:33 -0400
X-Google-Smtp-Source: AB8JxZqZIqE5NOnQGX4EhtUFNQuIXVc0Zxt3ieBFneb+yBmYQYNWG5GQmFhAMy2NbGvd7ZN2k7iO2Q==
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: =?UTF-8?Q?[RFD]=c2=a0Add_debugfs_for_cpuidle_=3f?=
Message-ID: <516d8599-8038-7b47-a3f5-640bf13856c2@linaro.org>
Date: Thu, 24 May 2018 10:14:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

would it be interesting to add debugfs metrics for cpuidle in order to
read some statistics from there and investigate the behavior ?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

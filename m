Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeD1THG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 15:07:06 -0400
Received: from mail.pwnoogle.com ([84.200.212.110]:43160 "EHLO pwnoogle.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751151AbeD1THF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 15:07:05 -0400
To: linux-kernel@vger.kernel.org
From: noisyb@pwnoogle.com
Subject: objdump: arch/x86/entry/.tmp_common.o: File format not recognized
Message-ID: <dc7b9512-b06b-46c7-cdef-cd1f307eb2f1@pwnoogle.com>
Date: Sat, 28 Apr 2018 21:01:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:51.0) Gecko/20100101
 Thunderbird/51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

4.1.51 compiles fine
4.16.1+ give me errors like in the subject... randomly...

I cant find a clue in Changes what is causing this... tools are all new enough...


Dirk

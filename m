Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933438AbeEIBOd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 21:14:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41580 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932988AbeEIBOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 21:14:31 -0400
Subject: Re: Using LIBIIO sending DATA to DAC and capturing the output from
 DAC
To: jarul <joearul09@gmail.com>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <1525828377261-0.post@n7.nabble.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e455a341-49eb-c9c3-89aa-3e090bdd8898@infradead.org>
Date: Tue, 8 May 2018 18:14:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525828377261-0.post@n7.nabble.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-iio mailing list]

On 05/08/2018 06:12 PM, jarul wrote:
> I would like to ask a question and if anybody can answer my question, I would
> very much appreciate.
> 
> I am using Z706 and AD9361. I have setup the SD card image on the server
> side and I have a client machine which is a Linux machine. I am using
> ad9361-iiostream file where I send my data using sin and cos function to DAC
> and try to get the output from DAC. If I send the random number which does
> not exceed 2047, do the left shift 4 bit and send the data to DAC. It
> creates a nice waveform file and the waveform can be seen on oscilloscope
> clearly.  Using random number I can get the output from DAC. However, when I
> send the sin and cos function, the output from DAC can not be captured or I
> get just 0 and one single value as output.
> 
> I have used iio_channel_read_raw function to capture the output else
> iio_channel_read function to capture the output from DAC. I want to capture
> the DAC output and then send the output to ADC and finally I want to capture
> the ADC output to compare the digital data on both side.
> 
> Can any export or whoever is familiar with the subject libiio can answer my
> question. Thanks a lot.
> 
> 
> 
> --
> Sent from: http://linux-kernel.2935.n7.nabble.com/


-- 
~Randy

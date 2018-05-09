Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933393AbeEIBGW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 21:06:22 -0400
Received: from n7.nabble.com ([162.253.133.57]:64395 "EHLO n7.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933141AbeEIBGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 21:06:21 -0400
Date: Tue, 8 May 2018 17:57:29 -0700 (MST)
From: jarul <joearul09@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <1525827449900-0.post@n7.nabble.com>
Subject: LIBIIO Question, Try to send data to DAC and capture the output
 from DAC
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to ask a question and if anybody can answer my question, I would
very much appreciate.

I am using Z706 and AD9361. I have setup the SD card image on the server
side and I have a client machine which is a Linux machine. I am using
ad9361-iiostream file where I send my data using sin and cos function to DAC
and try to get the output from DAC. If I send the random number which does
not exceed 2047, do the left shift 4 bit and send the data to DAC. It
creates a nice waveform file and the waveform can be seen on oscilloscope
clearly.  Using random number I can get the output from DAC. However, when I
send the sin and cos function, the output from DAC can not be captured or I
get just 0 and one single value as output.

I have used iio_channel_read_raw function to capture the output else
iio_channel_read function to capture the output from DAC. I want to capture
the DAC output and then send the output to ADC and finally I want to capture
the ADC output to compare the digital data on both side.

Can any export or whoever is familiar with the subject libiio can answer my
question? Thanks a lot.



--
Sent from: http://linux-kernel.2935.n7.nabble.com/

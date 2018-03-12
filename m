Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932294AbeCLN67 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:58:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCLN65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:58:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Mar 2018 19:28:55 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: "Christ, Austin" <austinwc@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>,
        David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] i2c: qup: reorganization of driver code to remove
 polling for qup v2
In-Reply-To: <a5257c10-c6f1-13e6-2281-977698793158@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-13-git-send-email-absahu@codeaurora.org>
 <a5257c10-c6f1-13e6-2281-977698793158@codeaurora.org>
Message-ID: <c339f16e2459a7a2d757d6ca75691908@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

>>   static void qup_i2c_set_blk_event(struct qup_i2c_dev *qup, bool 
>> is_rx)
>>   {
>>   	qup->cur_blk_events = 0;
>> @@ -1442,13 +1155,452 @@ static int qup_i2c_xfer(struct i2c_adapter 
>> *adap,
>>   	return ret;
>>   }
>>   +/*
>> + * Function to configure registers related with reconfiguration 
>> during run
>> + * and will be done before each I2C sub transfer.
>> + */
> Consider changing comment style to remove the word "Function" and
> state the operation in simple present tense.
> 
> "Function to configure ..." would be "Configure ..."
> 
> Same comment for all comments of this style below.
> 


  Thanks Austin.

  I have done the changes for comments styles in v2

  https://lkml.org/lkml/2018/3/12/421

  Regards,
  Abhishek

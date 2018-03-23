Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeCWOhY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:37:24 -0400
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:15536
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751471AbeCWOhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:37:22 -0400
Authentication-Results: spf=none (sender IP is 129.98.127.170)
 smtp.mailfrom=einstein.yu.edu; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=einstein.yu.edu;
From: Maurice R Volaski <maurice.volaski@einstein.yu.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Did kernel 3.11 never work?
Thread-Topic: Did kernel 3.11 never work?
Thread-Index: AQHTwrRxo/jE6/QgLkSKKNwiuRVesQ==
Date: Fri, 23 Mar 2018 14:37:17 +0000
Message-ID: <E513F076-24D5-4F67-A204-D2E6E1135FDE@einstein.yu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.c.0.180314
x-originating-ip: [10.49.98.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3EE95ADB132514A8FC5FFE9A74C9C99@yuad.uds.yu.edu>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:129.98.127.170;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(39380400002)(2980300002)(428003)(199004)(189003)(104016004)(105586002)(50466002)(5660300001)(7736002)(305945005)(6116002)(356003)(3846002)(33656002)(75432002)(82746002)(2900100001)(6916009)(2501003)(2351001)(109096001)(5640700003)(106466001)(8676002)(47776003)(186003)(26005)(102836004)(8936002)(88552002)(246002)(316002)(2906002)(786003)(86362001)(2486003)(58126008)(23676004)(336012)(436003)(83716003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR0401MB0994;H:smtp.einstein.yu.edu;FPR:;SPF:None;PTR:aewexcph01.yuad.uds.yu.edu;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT040;1:uXO9jct7ji5KWSBw9v+2WsRSEE4RbKOMPDI6pzxUwMSLpV51lzX2KaSS+g/ceR0mdCzt2NNET4wlII2YY2oDEZtA9aEl4zxQUpbko2AR1xeUkkaVXmpSoO5I7exeIFLA
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51fb8ea8-2550-4f8c-2688-08d590cb94c3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN1PR0401MB0994;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0401MB0994;3:va/tzky5+ZrNS72wWVRI7EOp/A2+Yv7YyUoMpGc1i028nM3iCdCFO69UGxOaOiC634/Yz4nXaOOG6DJli+3nMm9zSvHevxTe7tyOJa10Xfh7RD83c7hbg9JkV6sRwdLiwZiW4tj42fLK8OldgQwBxmtA+BvtQKNI1dZJ+yAKIz7N7PBTkQtn/BAZqitnfC6lDbudu5NsbnCCCHJqcX8KLVEBj2xtLDdPeLpw9lbEG1SbKWHMVFcOC9D2II9JUgIWdQjtaY8XteWm8cwdX3aSg772ogFGqfjio9ikZJrV0nwfmbYJe8RXapLxi3Dho+PdCS/Zhj5olgdVGPaP6m57Uj5ew/W49qoT0mWHyZftmms=;25:T6uJwS8j2J9doCVyPYSdpYCm1t620121sbeih8dTQwIN9WLjfXVbJTP6VWRNEyBX9HbIPs2TYDQKUdDcQitu68gk3sXUMHekqsPSO5N8pdz6yMbzvA0KnS0ginh+BkYOQ4BFtwsJlVMrv6wkx/0U6rtA4Eh2JiyoCJE12YlfM5PdTKhU0qnOWinr71j6e02jp6zxg9MZ6RF+LXXudNjzk8OrHsJg5D+AYTKalRIYTo69u4XDANAUEnM1+PitXK7hKV4kaclcN3iPbVTxaU8/0+8+OQHe0FwIfcU3W84gdjenUQokwQ/PJz9LxTuGGJw+vDCzd1Qi+E/sFhpya5QFAg==
X-MS-TrafficTypeDiagnostic: BN1PR0401MB0994:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0401MB0994;31:Is3qV/7p2CtRwtTImEqLXWMAZzAl41vnMz+BsDjhr6MMJFqp8V3vjNnnibo/rVezQnyJ8/qFeEmwiO1XMIdy3vgT9Gb1yzJal/4VB0JatYUF/fLwroaBbpsB7i9c9FzHQs6XkN88hSdPyf4WmTvnrqcryYK7iO+NEjwxHlrv4DuKRJsSkmo7oT+5melMMagWYhvYQh/nKf7fWudvDysLKzfMOJbNld+pCeHbRdsnJtA=;20:Mzn5yKGhrQkRJ7IU1eb4Ibr94ceshvTVg5tE2FV3nVZPoiX3TTq4e8YRUvC5oeMXa9h+Yinpxu1pa/KPvEhx5mQmqtVp6DmFNXRpEFIMaheSg2uwKKij+4inOLn+xAWy5T6REeQCgFMPRRAuaQH5xNhExk2Q70ThD0t2cZ4gCS73X54Z2ikmIxoveIQkJv6AQmIw+M4XTy35MCIk/dccTTRg/sW0zCDeC7odgzCJYZDvD4tU6f5jwbb/nBB9xXdh/XokUWH6Em9++lHAc4GuqOpckpacb9028pBdX0kFAtwmm8euKsoVUJDVtVEuQgm/7ztIxlcEhpm3wsno0vq8Bha3xSimkfLuCEiPlJ4Mkv7NTkezSyQQjrJuYeTcMkc123UFIRp1vfNv04fsddmUy41psWxN3dked7BO06RSRq8z5hcsTNWCXoN33UpRGIGEPfQ7cANcneMjhf69s5+BzUlNuSL/u/YslORSBzKwYTVcOr2tx+vxce4WPgB8+cN8
X-Microsoft-Antispam-PRVS: <BN1PR0401MB09944609331E59263EB81610AAA80@BN1PR0401MB0994.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN1PR0401MB0994;BCL:0;PCL:0;RULEID:;SRVR:BN1PR0401MB0994;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0401MB0994;4:HqWWZtLwVU4TPC8T3Qt98ROS+sLmC2901u6/b7js8RDBh16Y3qFv2YqwP4I8Jpw/woKR9xEkkx9WReyPO3BTack4v1CHJ9BUlLWytejJ00am2kyElq17qSmMNVrWBOOFMPKeYCOMtYC++T2Khoroim/5IUNSGzYPb468OobHHBY3vLjNQVtOXkB9J7i5tJXscHn+m/dFVsocy0elkGNd57RrCRQ4mgu9mwIH8j4XhY7WjRQWXXJuzXLGE6du31q60hJknXGdIYOLXeWkHqLVow==
X-Forefront-PRVS: 0620CADDF3
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjFQUjA0MDFNQjA5OTQ7MjM6Qk9pa1EwNDM1WFFNVksyTHpHT3BNODBN?=
 =?utf-8?B?dWd5T3JtUWR0by9xWDIzOFZCT0w2RHFSSGtMd3FUR1hGNkpWMkkyRHNKZy9t?=
 =?utf-8?B?TlRCR25vZEdQUVhQYUZEVVdpWkVkZnR1bmY0ejZ2NEZsRnQ5Z0pCczJPS3h5?=
 =?utf-8?B?S0o5ZDdPZGZoMkN4aTNYbHpiL0tDS2pQeE1HMVZUKzFPY0p3MVdwQzg0ZmM1?=
 =?utf-8?B?WUtOUlFyck5VdkJyRWlSb0VEajBCK3RENHg0NXBtT000QXQ3Y0ZCL0NWV1hO?=
 =?utf-8?B?TDlJblVOcy8wdURSeFRxLzgzZW1GeElkSzAyTG5tSDloT09jV3UrZ0tVcUxl?=
 =?utf-8?B?V09lNEI3T3VlMUY0d0xldEJ6VW1WZUhPNWMza2VZa1E0MmpxVithT2I3MVYz?=
 =?utf-8?B?R1I3N2JLZ0Q0YklLTzJ0M3pFK2ZROE1NQXVhbFE0bml0ZjJWWGt5OUxKL01p?=
 =?utf-8?B?dW5OOUQzUmJuMXF3ekFuL2dUYnBQdHVBS0VwNUlCTW1OTEtnWWtYZnh0NEMw?=
 =?utf-8?B?ZUplRjU2ZGdEN090Zk5keGQyVktnL3g3aURTdFo2SjgwTGpMblZmSG1sMjk1?=
 =?utf-8?B?MlNjMXV1cDh0aDRhUS9yR0VwdG45eHd4VkVYNE9xL3JMU2JhMS9Ya3Vjamdt?=
 =?utf-8?B?cFpDWnF3NUtFTldFRVVxamRqbFlIYjdVc0R1K2xhYnZsVkZMNHA4TGhWejNu?=
 =?utf-8?B?cVpOVlBZeGpYUktNQkR1QmxqS2FodFdPQXUyQlllWTBlL2xsdFR0d3hIckhB?=
 =?utf-8?B?SEdVSHBQaW1RSW45UE9jcXR5OGg1MVM2Y0VtemdjUGJUcVB3RXZXQjFqS1hU?=
 =?utf-8?B?bDRTL2krT1RvQlY4TGtnV1FYZ1VhNG9MZ3JWckJ6Wll6ZWhSTW9YMU1VZHRD?=
 =?utf-8?B?SnVxbG5HeCtkMWd0REd5cTExbmF2cVN1OE1xTnRPYUdLQU1xeVZ4QnF1Y2Qy?=
 =?utf-8?B?T0FhRFIvSlVXa1AzYnQ4WUVQdTU5TWxQeENOYlA1N3VXckpWTUk1azhyK2Uv?=
 =?utf-8?B?NEtFRlYwd1NqMk9JOEFIdTE4YVNBdlprelJFblZzWjliQUZlVWVaQTlZamdR?=
 =?utf-8?B?aUlvQ1BHRnlXdElDdCtnUW1CNG8wcG9nNEFlTVVVUlpxbStXcEIzbzJzV3o3?=
 =?utf-8?B?QUFJWUJLalMzeXF1SHBlemVmQ2c4L09RaXhyeGViMEhBYWJTWFZvR2pBeXZC?=
 =?utf-8?B?UW9JcWUwSVBySHpTbmlGR2Q0V28rZlB6ekNvcHlVdlRvbmpUem1Pd2JkMGU4?=
 =?utf-8?B?WHNOQ0ZoVlEvdFQ0dzZPN0Y1ZW4xYUZMTy9HeHcyUUJHTjFmTkRrNmREQXZj?=
 =?utf-8?B?MkNYTk5FQzVhdld6aDV4UmgvQlltL3pwWTBjN0J3Ym8vTEhYd1EraHdvVElR?=
 =?utf-8?B?L2dBakowL1F5T3ZzeklMSWY1VVpzRFBmM3JoNlRMcU1pT2d5QTQxemtzNnQx?=
 =?utf-8?Q?tfh10oDINud1eOXx/hSQTxE/0SpT8?=
X-Microsoft-Antispam-Message-Info: 1/5O2wVDrq/PW0pF4EL6wEJ516R+PFTmJCcYgRNtkyMW3Q3Ew6TQQwRdlXrhXZOmp881us3T0iAvYojjRd3rkaBax5zZe0PAfkEcy4hKCl2cwuI7SIvCaTcXRTw5EHIZG6DZrLnp2P8vTHxmHLK8uuDzfiRfGplOdYyd5eifpBlbLczGcpyvwA0mlZe1xkI1
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0401MB0994;6:AkuwBbfWbeiZooWR5gUPGK9024cRQc2zMQSjK1jRlKJvSr/5BPsgOHJR6Ol1claVqXUCeMZQ+nP6rwVWFvgnIswnqymCnutlEbA+hB/7mUef9AHfgyXJZvhyLOBHonGOF90Dhtaas2tAJVcDXwQ6xR2xymSrn4hyq3SQLBwR+4p4+ON/JXs3fAYS40O4cf6IBWDDgQzpaNbJahKd59dGgIkY6Q6jxJWCHycuw1yz+8yrmeaXkHl73y2qva647wDRQbS07bU/iK4T5HqLpKiLgz8e+hu94eMg3lwR+SKSwe6n4RlUYVRZ2ktlTi6jpradG1P3qqHA4Dp7IBEnAVprduUMHs13OGSCDm9xL2dENU1nLkYxNMQbKm5yV5vxdXNgGML9i5NqocMzh16Fh3kNbk7/Mlv9jla4g+/cOZUdOyRaSWLaVM/aktQMgh3xWALlmpzB96zEFAya9CF/C2zv2g==;5:hCykjFRJ380hxljopkARTE5K6LxZDhhlJU7ND/UE8OmCeo+V5EqcMK6hF2pSwrdjPL36Eqs8KZ76WE8tQs71j5NkG44Epw3nlLlzactCSiSHSBx7eGwOzZmFO/IeHgWBaVUJybYQbaIqrrVFXufH/yv5QJ3BuQea2mBY8eRfkD4=;24:GN6TQ9+ywdoeBoBOGJIeBSNUv2YMjq83HcWEmwdyNUSK8DJRHsSbuVSgFc4YDsdNzzKq99fS5fOdNm7driuLoIjLHjkERfbylvus2ReFeCU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0401MB0994;7:jE2JMDzWNGKPDK/jN8BvO7rzfPbQ2AxiO78fYwHFLaGEG7PZDruxs8rl0C2h62xXxZrtDVYYwfG5AHjLPRJMJiLde1nxpjYl4DIo37JQC08qzyo2iSJxV9xchSjBB1t9aFwm54TxEYQLHmsecLYAsKqGsASz5PZ009Cz+ZVNgPUH8lL2wkAtZ93nQApaibRuAcf0QeMo2C9CoDCZtRZspcSGVWl+RXaQz7C3s4ytUJiUJMX+cM4G9ebbIf7k49Ux
X-OriginatorOrg: einstein.yu.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 14:37:18.8402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fb8ea8-2550-4f8c-2688-08d590cb94c3
X-MS-Exchange-CrossTenant-Id: 04c70eb4-8f26-4807-9934-e02e89266ad0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=04c70eb4-8f26-4807-9934-e02e89266ad0;Ip=[129.98.127.170];Helo=[smtp.einstein.yu.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0401MB0994
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2NEbU3e030019

I am trying to use kernel 3.11 on VirtualBox or VMWare, but it hangs at boot right after the message “Booting the kernel”. Under VMWare, VMWare gives a message that it received an instruction to halt the CPU.

I have tried different editions of 3.11 and they all are affected the same way. Does anyone know why this and a way to fix it?
